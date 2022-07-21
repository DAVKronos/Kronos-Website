import React from "react";
import FormField from "../../Generic/FormField";
import { Form } from "react-bootstrap";
import { getFolders } from "../queries";

const folderFields = [
  {
    name: "name",
    type: "text",
    required: true,
  },
  {
    name: "folder_id",
    type: "reference",
    itemQuery: [['folders'], getFolders]
  }
];

// TODO: make required do something (with react-hook-form)
const FolderForm = ({ values, setValue, children }) => {
  return (
    <Form>
      {folderFields.map(
        ({ name, type, required, itemQuery, ...otherProps }) => {
          
          return (
            <FormField
              {...otherProps}
              key={name}
              modelName={"folder"}
              fieldName={name}
              value={values[name]}
              setValue={(v) => setValue(name, v)}
              type={type}
              required={required}
              itemQuery={itemQuery}
            />
          );
        }
      )}
      {children}
    </Form>
  );
};

export default FolderForm;
