import React        from 'react';
import ReactModal   from 'react-modal';
import Form         from './form';

export default class Modal extends React.Component {

  static propTypes = {
    application: React.PropTypes.shape({
      name: React.PropTypes.string,
    }),
    isOpen: React.PropTypes.bool.isRequired,
    closeModal: React.PropTypes.func.isRequired,
    save: React.PropTypes.func,
  };

  render() {
    return (
      <ReactModal
        isOpen={this.props.isOpen}
        onRequestClose={() => this.props.closeModal()}
        save={this.props.save}
        contentLabel="Modal"
        overlayClassName="c-modal__background"
        className="c-modal c-modal--settings is-open"
      >
        <h2 className="c-modal__title">{this.props.application.name} Settings</h2>
        <Form
          application={this.props.application}
          onChange={(e) => { this.newApplicationInstanceChange(e); }}
          closeModal={() => this.props.closeModal()}
        />
      </ReactModal>
    );
  }
}
