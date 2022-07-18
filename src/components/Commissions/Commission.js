import React, { useState } from "react";
import { Table, Button } from "react-bootstrap";
import { useQuery, useQueryCache } from "react-query";
import { useTranslation } from "react-i18next";
import {
  createCommissionMembership,
  getCommission,
  getCommissionMemberships,
  removeCommissionMembership,
} from "./queries";
import DefaultSpinner from "../Generic/Spinner";
import MultiLanguageText from "../Generic/MultiLanguageText";
import { FieldControl } from "../Generic/FormField";
import { Can } from "../../utils/auth-helper";

import { getUsers } from "../Users/queries";

const NewCommissionMember = ({ commissionId }) => {
  const [userId, setUserId] = useState(null);
  const [commissionFunction, setCommissionFunction] = useState(null);
  const [creating, setCreating] = useState(false);
  const { t } = useTranslation("generic");
  const queryCache = useQueryCache();
  const onClickCreate = () => {
    if (userId && commissionFunction) {
      setCreating(true);
      const data = {
        user_id: userId,
        function: commissionFunction,
        commission_id: commissionId,
      };
      createCommissionMembership(commissionId, data).then(() => {
        setCreating(false);
        queryCache.invalidateQueries(
          ["commissions", commissionId, "commission_memberships"],
          { exact: true }
        );
        setUserId(null);
        setCommissionFunction(null);
      });
    }
  };

  return (
    <tr>
      <td>
        <FieldControl
          value={userId}
          setValue={(v) => setUserId(v)}
          type={"reference"}
          required={true}
          size="sm"
          itemQuery={[["users"], getUsers]}
        />
      </td>
      <td>
        <FieldControl
          value={commissionFunction}
          setValue={(v) => setCommissionFunction(v)}
          type={"text"}
          required={true}
        />
      </td>
      <td>
        <Button onClick={onClickCreate} size="sm" variant={"success"}>
          {creating ? <DefaultSpinner inline size="sm" /> : t("add")}
        </Button>
      </td>
    </tr>
  );
};

const CommissionMembershipRow = ({ membership, removeFunction }) => {
  const name = membership.user && membership.user.name;
  const [removing, setRemoving] = useState(false);

  const onClickRemove = () => {
    setRemoving(true);
    removeFunction(membership.id).then(() => {
      setRemoving(false);
    });
  };
  return (
    <tr key={membership.id}>
      <td>{name}</td>
      <td>{membership.function}</td>
      <td>
        <Can I="delete" a={"CommissionMembership"}>
          <Button
            variant="danger"
            disabled={removing}
            size="sm"
            onClick={onClickRemove}
          >
            {removing ? <DefaultSpinner inline size="sm" /> : "Verwijder"}
          </Button>
        </Can>
      </td>
    </tr>
  );
};

function Commission(props) {
  const id = parseInt(props.match.params.id);
  const queryCache = useQueryCache();
  const { isLoading, isError, data, error } = useQuery(
    ["commissions", id],
    getCommission
  );

  const { isLoading: isMembershipsLoading, data: memberships } = useQuery(
    ["commissions", id, "commission_memberships"],
    getCommissionMemberships
  );
  if (isLoading) {
    return <DefaultSpinner />;
  }

  const commission = data;
  if (!commission) {
    return <h1>Commission not found</h1>;
  }

  const removeFunction = (membershipId) => {
    return removeCommissionMembership(commission.id, membershipId).then(() => {
      queryCache.invalidateQueries(
        ["commissions", commission.id, "commission_memberships"],
        { exact: true }
      );
    });
  };

  return (
    <React.Fragment>
      <h1>
        <MultiLanguageText nl={commission.name} en={commission.name_en} />
      </h1>
      <p className={"lead"}>
        <MultiLanguageText
          nl={commission.description}
          en={commission.description_en}
        />
      </p>
      <Table striped>
        <thead>
          <tr>
            <th>Naam</th>
            <th>Functie</th>
            <Can I="delete" a="CommissionMembership">
              <th>Action</th>
            </Can>
          </tr>
        </thead>
        <tbody>
          {memberships &&
            memberships.map((membership) => {
              return (
                <CommissionMembershipRow
                  key={membership.id}
                  removeFunction={removeFunction}
                  membership={membership}
                />
              );
            })}

          <Can I="create" a="CommissionMembership">
            <NewCommissionMember commissionId={commission.id} />
          </Can>
        </tbody>
      </Table>
      {isMembershipsLoading && <DefaultSpinner />}
    </React.Fragment>
  );
}

export default Commission;
