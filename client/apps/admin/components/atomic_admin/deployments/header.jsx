import React, {useState} from 'react';
import PropTypes from 'prop-types';
import Modal from './modal';
import { create } from 'lodash';

export default function Header(props) {
  const {
    fields,
    saveElement,
    staticElementFields
    
  } = props;

  const [createModalOpen, setCreateModalOpen] = useState(false);


  return (
    <div className="c-info">
      <div className="c-title">
        <h1>Lti Deployments</h1>
      </div>
      <button className="c-btn c-btn--yellow" onClick={() => setCreateModalOpen(true)}>
        New Deployment
      </button>
      <Modal
          formType={"platform_guid"}
          isOpen={createModalOpen}
          closeModal={() => setCreateModalOpen(false)}
          fields={fields}
          selectedElement={{}}
          saveElement={(formData) => saveElement(formData)}
          staticElementFields={{...staticElementFields}}
        />

    </div>
  );
}

Header.propTypes = {
  newPlatform: PropTypes.func.isRequired,
};
