import React                from 'react';
import { connect }          from 'react-redux';
import ReactModal           from 'react-modal';

import CanvasAuthentication from '../../../components/common/canvas_authentication';
import SiteForm             from './form';
import * as SiteActions from '../../actions/sites';

const select = state => ({
  settings: state.settings,
  siteToOauth: state.siteToOauth
});

export class SiteModal extends React.Component {
  static propTypes = {
    site: React.PropTypes.shape({
      id: React.PropTypes.number,
    }),
    createSite: React.PropTypes.func.isRequired,
    updateSite: React.PropTypes.func.isRequired,
    isOpen: React.PropTypes.bool.isRequired,
    closeModal: React.PropTypes.func.isRequired,
    settings: React.PropTypes.shape({
      lti_key: React.PropTypes.string
    }).isRequired,
    siteToOauth: React.PropTypes.string,
  };

  constructor(props) {
    super(props);
    this.state = {
      site: props.site || {},
    };
  }

  componentWillReceiveProps(nextProps) {
    this.setState({
      site: nextProps.site,
    });
  }

  getCanvasAuthForm() {
    if (this.props.siteToOauth) {
      return (
        <CanvasAuthentication
          autoSubmit
          hideButton
          overrides={{
            canvas_url: this.props.siteToOauth,
            admin_url: window.location.href,
            oauth_consumer_key: this.props.settings.lti_key,
          }}
        />
      );
    }

    return null;
  }

  setupSite() {
    const {
      site,
    } = this.state;
    const isUpdate = !!(site && site.id);

    if (isUpdate) {
      this.props.updateSite(site);
    } else {
      this.props.createSite(site);
    }
  }

  siteChange(e) {
    this.setState({
      site: {
        ...this.state.site,
        [e.target.name]: e.target.value
      }
    });
  }

  render() {
    const {
      site,
    } = this.state;
    const isUpdate = !!(site && site.id);

    return (
      <ReactModal
        isOpen={this.props.isOpen}
        onRequestClose={() => this.props.closeModal()}
        contentLabel="Modal"
        overlayClassName="unused"
        className="c-modal c-modal--site is-open"
      >
        {this.getCanvasAuthForm()}
        <h2 className="c-modal__title">New Domain</h2>
        <SiteForm
          isUpdate={isUpdate}
          onChange={e => this.siteChange(e)}
          setupSite={() => this.setupSite()}
          closeModal={() => this.props.closeModal()}
          {...this.state.site}
        />
      </ReactModal>
    );
  }
}

export default connect(select, { ...SiteActions })(SiteModal);
