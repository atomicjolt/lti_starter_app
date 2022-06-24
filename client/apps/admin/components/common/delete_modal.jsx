import React from 'react';
import PropTypes from 'prop-types';
import ReactModal from 'react-modal';

export default function DeleteModal(props) {
  return (
    <ReactModal
      isOpen={props.isOpen}
      onRequestClose={() => props.closeModal()}
      contentLabel="Modal"
      overlayClassName="unused"
      className="c-modal c-modal--site is-open"
    >
      <h2 className="c-modal__title">Are you sure?</h2>
      <form>
        <button
          type="button"
          className="c-btn c-btn--red"
          onClick={() => props.deleteRecord()}
        >
          Yes
        </button>
        <button
          type="button"
          className="c-btn c-btn--gray--large u-m-right"
          onClick={() => props.closeModal()}
        >
          Cancel
        </button>
      </form>
    </ReactModal>
  );
}

DeleteModal.propTypes = {
  deleteRecord: PropTypes.func.isRequired,
  isOpen: PropTypes.bool.isRequired,
  closeModal: PropTypes.func.isRequired,
};
