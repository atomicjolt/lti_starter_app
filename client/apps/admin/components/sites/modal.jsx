import _ from 'lodash';
import React from 'react';
import PropTypes from 'prop-types';
import { connect } from 'react-redux';
import ReactModal from 'react-modal';

import SiteForm from './form';
import * as SiteActions from '../../actions/sites';
import { canvasDevKeysUrl } from '../../libs/sites';

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

  setupSite() {
    const {
      site,
    } = this.state;
    const isUpdate = !!(site && site.id);

    if (this.hasUrlError()) {
      return;
    }

    if (isUpdate) {
      this.props.updateSite(site);
    } else {
      this.props.createSite(site);
    }
    this.props.closeModal();
  }

  siteChange(e) {
    this.setState({
      site: {
        ...this.state.site,
        [e.target.name]: e.target.value
      }
    });
  }

  hasUrlError() {
    const { site } = this.state;
    return site &&
      site.url &&
      site.url.length > 8 && // Must be longer than just https://
      !_.startsWith(site.url, 'https://');
  }

  render() {
    const { site } = this.state;
    const isUpdate = !!(site && site.id);
    const verb = isUpdate ? 'Update' : 'New';

    const callbackUrl = this.props.settings.canvas_callback_url;
    let canvasDevInstructions = 'Add a canvas domain first.';
    if (site && site.url) {
      canvasDevInstructions = (
        <div>
          <div>
            You will need a redirect URI: {callbackUrl}
          </div>
          <div>
            <a href={canvasDevKeysUrl(site)} className="c-modal__subtext-link" target="_blank" rel="noopener noreferrer" >
              Get Canvas Developer Keys Here
            </a>
          </div>
        </div>
      );
    }

    let urlError = null;
    if (this.hasUrlError()) {
      urlError = 'Url must begin with "https://"';
    }

    return (
      <ReactModal
        isOpen={this.props.isOpen}
        onRequestClose={() => this.props.closeModal()}
        contentLabel="Modal"
        overlayClassName="unused"
        className="c-modal c-modal--site is-open"
      >
        <h2 className="c-modal__title">{verb} Domain</h2>
        <h3 className="c-modal__subtext">{canvasDevInstructions}</h3>
        <h3 className="c-modal__subtext">{urlError}</h3>
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
