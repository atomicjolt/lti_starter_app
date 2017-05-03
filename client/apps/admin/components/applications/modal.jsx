import React from 'react';
import PropTypes from 'prop-types';
import ReactModal from 'react-modal';
import Form from './form';

export default class Modal extends React.Component {

  static propTypes = {
    application: PropTypes.shape({
      name: PropTypes.string,
      description: PropTypes.string,
      default_config: PropTypes.string,
      canvas_api_permissions: PropTypes.string,
    }),
    isOpen: PropTypes.bool.isRequired,
    closeModal: PropTypes.func.isRequired,
    save: PropTypes.func,
  };

  constructor(props) {
    super();
    this.state = {
      application: { ...props.application },
      configParseError: null,
    };
  }

  applicationChange(e) {
    let configParseError = null;
    if (e.target.name === 'default_config') {
      try {
        JSON.parse(e.target.value || '{}');
      } catch (err) {
        configParseError = err.toString();
      }
    }
    this.setState({
      application: {
        ...this.state.application,
        [e.target.name]: e.target.value,
      },
      configParseError,
    });
  }

  saveApplication() {
    this.props.save(this.state.application);
  }

  render() {
    return (
      <ReactModal
        isOpen={this.props.isOpen}
        onRequestClose={() => this.props.closeModal()}
        save={this.saveApplication}
        contentLabel="Modal"
        overlayClassName="c-modal__background"
        className="c-modal c-modal--settings is-open"
      >
        <h2 className="c-modal__title">{this.state.application.name} Settings</h2>
        <Form
          description={this.state.application.description}
          canvasApiPermissions={this.props.application.canvas_api_permissions}
          defaultConfig={this.state.application.default_config}
          configParseError={this.state.configParseError}
          onChange={(e) => { this.applicationChange(e); }}
          closeModal={() => this.props.closeModal()}
          save={() => this.saveApplication()}
        />
      </ReactModal>
    );
  }
}
