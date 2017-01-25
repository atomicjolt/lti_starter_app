import React              from 'react';
import ReactModal         from 'react-modal';
import ReactSelect        from 'react-select';
import NewSiteModal       from './new_site_modal';

export default class NewInstanceModal extends React.Component {
  static propTypes = {
    isOpen: React.PropTypes.bool.isRequired,
    closeModal: React.PropTypes.func.isRequired,
    sites: React.PropTypes.shape({})
  };

  constructor() {
    super();
    this.state = {
      newSiteModalOpen: false,
      selectedSite: ''
    };
  }

  selectSite(option) {
    if (_.isFunction(option.onSelect)) {
      option.onSelect();
    }
    this.setState({ selectedSite: option.value })
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

  render() {
    const options = _.map(this.props.sites, site => ({
      label: site.url,
      value: site.id
    })).concat({
      label: <div>Add New</div>,
      value: 'new',
      onSelect: () => this.newSite()
    });

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

        <div className="o-grid o-grid__modal-top">
          <div className="o-grid__item u-half">
            <div className="c-input"><span>Domain</span>
              <ReactSelect
                tabIndex="-1"
                ref={(ref) => { this.siteSelector = ref; }}
                options={options}
                value={this.state.selectedSite}
                name="site"
                placeholder="Select a Domain"
                onChange={option => this.selectSite(option)}
                searchable={false}
                arrowRenderer={() => null}
                clearable={false}
              />
            </div>
          </div>
          <div className="o-grid__item u-half">
            <label className="c-input"><span>LTI Key</span><input type="text" /></label>
          </div>
          <div className="o-grid__item u-half">
            <label className="c-input"><span>LTI Secret</span><input type="text" /></label>
          </div>
          <div className="o-grid__item u-half">
            <label className="c-input"><span>LTI Consumer</span><input type="text" /></label>
          </div>
          <div className="o-grid__item u-half">
            <label className="c-input"><span>Canvas Token</span><input type="text" /></label>
          </div>
        </div>

        <h3 className="c-modal__subtitle">Install Settings</h3>
        <div className="o-grid o-grid__bottom">
          <div className="o-grid__item u-third">
            <label className="c-checkbox"><input type="checkbox" />Account Navigation</label>
          </div>
          <div className="o-grid__item u-third">
            <label className="c-checkbox"><input type="checkbox" />General</label>
          </div>
          <div className="o-grid__item u-third">
            <label className="c-checkbox"><input type="checkbox" />Editor Button</label>
          </div>
          <div className="o-grid__item u-third">
            <label className="c-checkbox"><input type="checkbox" />Course Navigation</label>
          </div>
        </div>
        <button className="c-btn c-btn--yellow">Save</button>
        <button className="c-btn c-btn--gray--large u-m-right" onClick={() => this.closeModal()}>Cancel</button>
        <NewSiteModal
          isOpen={this.state.newSiteModalOpen}
          closeModal={() => this.closeNewSiteModal()}
        />
      </ReactModal>
    );
  }
}
