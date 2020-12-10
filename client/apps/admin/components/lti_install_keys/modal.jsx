import React from 'react';
import PropTypes from 'prop-types';
import ReactModal from 'react-modal';
import LtiInstallKeyForm from './form';

export default class Modal extends React.Component {
  static propTypes = {
    closeModal: PropTypes.func.isRequired,
    save: PropTypes.func.isRequired,
    ltiInstallKey: PropTypes.shape({
      id: PropTypes.number,
      iss: PropTypes.string,
      clientId: PropTypes.string,
      jwksUrl: PropTypes.string,
      tokenUrl: PropTypes.string,
      oidcUrl: PropTypes.string,
    }),
    application: PropTypes.shape({
      id: PropTypes.number,
    }),
  };

  constructor(props) {
    super(props);
    this.state = {
      newLtiInstallKey: props.ltiInstallKey || {}
    };
  }

  closeModal() {
    this.props.closeModal();
  }

  newLtiInstallKeyChange(e) {
    this.setState({
      newLtiInstallKey: {
        ...this.state.newLtiInstallKey,
        [e.target.name]: e.target.value
      },
    });
  }

  save() {
    this.props.save(
      this.props.application.id,
      this.state.newLtiInstallKey
    );
    this.props.closeModal();
  }

  render() {
    let title = 'New';

    const {
      ltiInstallKey,
    } = this.props;

    if (ltiInstallKey && ltiInstallKey.id) {
      title = 'Update';
    }

    return (
      <ReactModal
        isOpen
        onRequestClose={() => this.closeModal()}
        contentLabel="Lti Install Key Modal"
        overlayClassName="c-modal__background"
        className="c-modal c-modal--settings is-open"
      >
        <h2 className="c-modal__title">
          {title} Lti Install Key
        </h2>
        <LtiInstallKeyForm
          {...this.state.newLtiInstallKey}
          onChange={(e) => { this.newLtiInstallKeyChange(e); }}
          save={() => this.save()}
          closeModal={() => this.closeModal()}
        />
      </ReactModal>
    );
  }
}
