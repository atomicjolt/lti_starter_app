import React, {useState} from 'react';
import PropTypes from 'prop-types';
import Modal from './modal';
import { create } from 'lodash';

export default function Header(props) {
  const {
    createPlatform,
    fields
  } = props;

  const [createModalOpen, setCreateModalOpen] = useState(false);


  return (
    <div className="c-info">
      <div className="c-title">
        <h1>Lti Platforms</h1>
      </div>
      <button className="c-btn c-btn--yellow" onClick={() => setCreateModalOpen(true)}>
        New Platform
      </button>
      <Modal
          isOpen={createModalOpen}
          closeModal={() => setCreateModalOpen(false)}
          fields={fields}
          selectedElement={{}}
          saveElement={(formData) => createPlatform(formData)}
        />

    </div>
  );
}

Header.propTypes = {
  newPlatform: PropTypes.func.isRequired,
};
