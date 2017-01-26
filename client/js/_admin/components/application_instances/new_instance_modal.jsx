import React                          from 'react';
import ReactModal                     from 'react-modal';
import NewSiteModal                   from './new_site_modal';
import NewInstanceForm                from './new_instance_form';

export default class NewInstanceModal extends React.Component {
  static propTypes = {
    isOpen: React.PropTypes.bool.isRequired,
    closeModal: React.PropTypes.func.isRequired,
    sites: React.PropTypes.shape({}),
    createApplicationInstance: React.PropTypes.func.isRequired,
  };

  constructor() {
    super();
    this.state = {
      newSiteModalOpen: false,
      selectedSite: '',
      newInstance: {}
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

  newInstanceChange(e) {
    this.setState({
      newInstance: {
        ...this.state.newInstance,
        [e.target.name]: e.target.value
      }
    });
  }

  createInstance() {
    this.props.createApplicationInstance(
      this.props.applicationId,
      this.state.newInstance
    );
    this.props.closeModal();
  }

  render() {
    return (
      <ReactModal
        isOpen={this.props.isOpen}
        onRequestClose={() => this.closeModal()}
        contentLabel="Modal"
        overlayClassName="c-modal__background"
        className={`c-modal c-modal--settings ${this.showInstanceModal()}`}
      >
        <h2 className="c-modal__title">Attendance Settings</h2>
        <h3 className="c-modal__instance">Air University</h3>
        <NewInstanceForm
          {...this.state.newInstance}
          onChange={(e) => { this.newInstanceChange(e); }}
          createInstance={() => this.createInstance()}
          sites={this.props.sites}
          closeModal={() => this.closeModal()}
          newSite={() => this.newSite()}
        />
        <NewSiteModal
          isOpen={this.state.newSiteModalOpen}
          closeModal={() => this.closeNewSiteModal()}
        />
      </ReactModal>
    );
  }
}
