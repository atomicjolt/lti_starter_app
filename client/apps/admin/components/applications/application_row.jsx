import React, { useState } from 'react';
import PropTypes from 'prop-types';
import { Link } from 'react-router3';
import Modal from './modal';

const getStyles = () => ({
  buttonIcon: {
    border: 'none',
    backgroundColor: 'transparent',
    color: 'grey',
    fontSize: '1.5em',
    cursor: 'pointer',
  }
});

export default function ApplicationRow(props) {
  const [modalOpen, setModalOpen] = useState(false);
  const {
    application,
    saveApplication
  } = props;

  const styles = getStyles();
  return (
    <tr>
      <td>
        <Link to={`/applications/${application.id}/application_instances`}>{application.name}</Link>
      </td>
      <td>
        <Link to={`/applications/${application.id}/lti_install_keys`}>Manage Keys</Link>
      </td>
      <td><span>{application.application_instances_count}</span></td>
      <td>
        <button
          type="button"
          style={styles.buttonIcon}
          onClick={() => setModalOpen(true)}
        >
          <i className="material-icons">settings</i>
        </button>
        <Modal
          isOpen={modalOpen}
          application={application}
          closeModal={() => setModalOpen(false)}
          save={saveApplication}
        />
      </td>
    </tr>
  );

}

ApplicationRow.propTypes = {
  application: PropTypes.shape({
    id                          : PropTypes.number,
    name                        : PropTypes.string,
    application_instances_count : PropTypes.number,
  }).isRequired,
  saveApplication: PropTypes.func.isRequired,
};
