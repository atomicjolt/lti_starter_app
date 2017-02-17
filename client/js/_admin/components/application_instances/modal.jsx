import React                   from 'react';
import ReactModal              from 'react-modal';
import NewSiteModal            from '../sites/modal';
import ApplicationInstanceForm from './form';

export default class Modal extends React.Component {
  static propTypes = {
    isOpen: React.PropTypes.bool.isRequired,
    closeModal: React.PropTypes.func.isRequired,
    sites: React.PropTypes.shape({}),
    save: React.PropTypes.func.isRequired,
    applicationInstance: React.PropTypes.shape({
      id: React.PropTypes.number,
      site: React.PropTypes.shape({
        id: React.PropTypes.number,
      })
    }),
    application: React.PropTypes.shape({
      id: React.PropTypes.number,
    })
  };

  constructor(props) {
    super(props);
    this.state = {
      newSiteModalOpen: false,
      selectedSite: '',
      newApplicationInstance: props.applicationInstance || {}
    };
  }

  newSite() {
    this.setState({ newSiteModalOpen: true });
  }

  closeNewSiteModal() {
    this.setState({ newSiteModalOpen: false, selectedSite: '' });
  }

  showInstanceModal() {
    if (this.props.isOpen && !this.state.newSiteModalOpen) {
      return 'is-open';
    }
    return '';
  }

  closeModal() {
    this.closeNewSiteModal();
    this.props.closeModal();
  }

  newApplicationInstanceChange(e) {
    this.setState({
      newApplicationInstance: {
        ...this.state.newApplicationInstance,
        [e.target.name]: e.target.value
      }
    });
  }

  createInstance() {
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
          onChange={(e) => { this.newApplicationInstanceChange(e); }}
          createInstance={() => this.createInstance()}
          sites={this.props.sites}
          site_id={`${siteId}`}
          closeModal={() => this.closeModal()}
          newSite={() => this.newSite()}
          isUpdate={isUpdate}
        />
        <NewSiteModal
          isOpen={this.state.newSiteModalOpen}
          closeModal={() => this.closeNewSiteModal()}
        />
      </ReactModal>
    );
  }
}
