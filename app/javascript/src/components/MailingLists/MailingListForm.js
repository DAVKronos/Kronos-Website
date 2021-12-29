import React from "react";
import FormField from "../Generic/FormField";
import { Form } from "react-bootstrap";
import { getCommissions, getUsersForCommission } from "../Commissions/queries";
import { getAliases } from "../Aliases/queries";
import { getUsers } from "../Users/queries";

const mailingListFields = [
  {
    name: "name",
    type: "text",
    required: true,
  },
  {
    name: "description",
    type: "text",
    required: true,
  },
  {
    name: "local_part",
    type: "text",
    required: true,
  },
  {
    name: "commission_id",
    type: "reference",
    required: false,
    itemQuery: [["commissions"], getCommissions],
  },
  {
    name: "alias_ids",
    type: "reference",
    required: false,
    multiple: true,
    itemQuery: [["aliases"], getAliases],
  },
  {
    name: "user_ids",
    type: "reference",
    required: false,
    multiple: true,
    itemQuery: (commissionId) =>
      commissionId
        ? [["commissions", commissionId, "users"], getUsersForCommission]
        : [["users"], getUsers],
  },
];

// TODO: make required do something (with react-hook-form)
const MailingListForm = ({ values, setValue, children }) => {
  return (
    <Form>
      {mailingListFields.map(
        ({ name, type, required, itemQuery, ...otherProps }) => {
          let newItemQuery =
            name === "user_ids"
              ? itemQuery(values["commission_id"])
              : itemQuery;
          return (
            <FormField
              {...otherProps}
              key={name}
              modelName={"mailingList"}
              fieldName={name}
              value={values[name]}
              setValue={(v) => setValue(name, v)}
              type={type}
              required={required}
              itemQuery={newItemQuery}
            />
          );
        }
      )}
      {children}
    </Form>
  );
};

export default MailingListForm;
