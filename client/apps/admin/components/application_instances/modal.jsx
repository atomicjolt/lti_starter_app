import React from 'react';
import PropTypes from 'prop-types';
import ReactModal from 'react-modal';
import SiteModal from '../sites/modal';
import ApplicationInstanceForm from './form';

export default class Modal extends React.Component {
  static propTypes = {
    isOpen: PropTypes.bool.isRequired,
    closeModal: PropTypes.func.isRequired,
    sites: PropTypes.shape({}),
    save: PropTypes.func.isRequired,
    applicationInstance: PropTypes.shape({
      id: PropTypes.number,
      config: PropTypes.string,
      site: PropTypes.shape({
        id: PropTypes.number,
      })
    }),
    application: PropTypes.shape({
      id: PropTypes.number,
    })
  };

  constructor(props) {
    super(props);
    this.state = {
      siteModalOpen: false,
      newApplicationInstance: props.applicationInstance || {}
    };
  }

  newSite() {
    this.setState({ siteModalOpen: true });
  }

  closeSiteModal() {
    this.setState({ siteModalOpen: false });
  }

  showInstanceModal() {
    if (this.props.isOpen && !this.state.siteModalOpen) {
      return 'is-open';
    }
    return '';
  }

  closeModal() {
    this.closeSiteModal();
    this.props.closeModal();
  }

  newApplicationInstanceChange(e) {
    let configParseError = null;
    if (e.target.name === 'config') {
      try {
        JSON.parse(e.target.value || '{}');
      } catch (err) {
        configParseError = err.toString();
      }
    }

    this.setState({
      newApplicationInstance: {
        ...this.state.newApplicationInstance,
        [e.target.name]: e.target.value
      },
      configParseError,
    });
  }

  save() {
    this.props.save(
      this.props.application.id,
      this.state.newApplicationInstance
    );
    this.props.closeModal();
  }

  render() {
    const application = this.props.application;
    const applicationName = application ? application.name : 'Application';
    let title = 'New';
    let siteId;
    if (this.state.newApplicationInstance.site_id ||
        (this.props.applicationInstance && this.props.applicationInstance.id)) {
      title = 'Update';
      siteId = this.state.newApplicationInstance.site_id || this.props.applicationInstance.site.id;
    }
    const isUpdate = !!(this.props.applicationInstance && this.props.applicationInstance.id);

    return (
      <ReactModal
        isOpen={this.props.isOpen}
        onRequestClose={() => this.closeModal()}
        contentLabel="Application Instances Modal"
        overlayClassName="c-modal__background"
        className={`c-modal c-modal--settings ${this.showInstanceModal()}`}
      >
        <h2 className="c-modal__title">
          {title} {applicationName} Instance
        </h2>
        <ApplicationInstanceForm
          {...this.state.newApplicationInstance}
          configParseError={this.state.configParseError}
          onChange={(e) => { this.newApplicationInstanceChange(e); }}
          save={() => this.save()}
          sites={this.props.sites}
          site_id={`${siteId}`}
          closeModal={() => this.closeModal()}
          newSite={() => this.newSite()}
          isUpdate={isUpdate}
        />
        <SiteModal
          isOpen={this.state.siteModalOpen}
          closeModal={() => this.closeSiteModal()}
        />
      </ReactModal>
    );
  }
}
