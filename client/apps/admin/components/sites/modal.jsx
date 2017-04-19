import React from 'react';
import PropTypes from 'prop-types';
import { connect } from 'react-redux';
import ReactModal from 'react-modal';

import CanvasAuthentication from '../../../../libs/canvas/components/canvas_authentication';
import SiteForm from './form';
import * as SiteActions from '../../actions/sites';

const select = state => ({
  settings: state.settings,
  siteToOauth: state.siteToOauth
});

export class SiteModal extends React.Component {
  static propTypes = {
    site: PropTypes.shape({
      id: PropTypes.number,
    }),
    createSite: PropTypes.func.isRequired,
    updateSite: PropTypes.func.isRequired,
    isOpen: PropTypes.bool.isRequired,
    closeModal: PropTypes.func.isRequired,
    settings: PropTypes.shape({
      lti_key: PropTypes.string,
      canvas_callback_url: PropTypes.string,
    }).isRequired,
    siteToOauth: PropTypes.string,
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
    const verb = isUpdate ? 'Update' : 'New';

    const callbackUrl = this.props.settings.canvas_callback_url;
    let canvasDevInstructions = 'Add a canvas domain first.';
    if (site && site.url) {
      const canvasDevKeysUrl = `${site.url}/accounts/site_admin/developer_keys`;
      canvasDevInstructions = (
        <div>
          <div>
            You will need a redirect URI: {callbackUrl}
          </div>
          <div>
            <a href={canvasDevKeysUrl} className="c-modal__subtext-link" target="_blank" rel="noopener noreferrer" >
              Get Canvas Developer Keys Here
            </a>
          </div>
        </div>
      );
    }

    return (
      <ReactModal
        isOpen={this.props.isOpen}
        onRequestClose={() => this.props.closeModal()}
        contentLabel="Modal"
        overlayClassName="unused"
        className="c-modal c-modal--site is-open"
      >
        {this.getCanvasAuthForm()}
        <h2 className="c-modal__title">{verb} Domain</h2>
        <h3 className="c-modal__subtext">{canvasDevInstructions}</h3>
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
