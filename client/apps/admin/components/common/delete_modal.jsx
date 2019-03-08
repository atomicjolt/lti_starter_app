import React from 'react';
import PropTypes from 'prop-types';
import ReactModal from 'react-modal';

export default class DeleteModal extends React.Component {
  static propTypes = {
    deleteRecord: PropTypes.func.isRequired,
    isOpen: PropTypes.bool.isRequired,
    closeModal: PropTypes.func.isRequired,
  };

  render() {
    return (
      <ReactModal
        isOpen={this.props.isOpen}
        onRequestClose={() => this.props.closeModal()}
        contentLabel="Modal"
        overlayClassName="unused"
        className="c-modal c-modal--site is-open"
      >
        <h2 className="c-modal__title">Are you sure?</h2>
        <form>
          <button
            type="button"
            className="c-btn c-btn--red"
            onClick={() => this.props.deleteRecord()}
          >
            Yes
          </button>
          <button
            type="button"
            className="c-btn c-btn--gray--large u-m-right"
            onClick={() => this.props.closeModal()}
          >
            Cancel
          </button>
        </form>
      </ReactModal>
    );
  }
}
