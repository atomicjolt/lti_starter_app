import React                from 'react';
import { connect }          from 'react-redux';
import ReactModal           from 'react-modal';

import CanvasAuthentication from '../../../components/common/canvas_authentication';
import NewSiteForm          from './new_site_form';
import { createSite }       from '../../actions/sites';

const select = state => ({
  settings    : state.settings,
  siteToOauth : state.siteToOauth
});

export class NewSiteModal extends React.Component {
  static propTypes = {
    createSite    : React.PropTypes.func.isRequired,
    isOpen        : React.PropTypes.bool.isRequired,
    siteToOauth   : React.PropTypes.string.isRequired,
    closeModal    : React.PropTypes.func.isRequired,
  };

  constructor() {
    super();
    this.state = {
      newSite: {}
    };
  }

  getCanvasAuthForm() {
    if (this.props.siteToOauth) {
      return (
        <CanvasAuthentication
          autoSubmit
          hideButton
          overrides={{
            canvas_url : this.props.siteToOauth,
            admin_url  : window.location.href
          }}
        />
      );
    }

    return null;
  }

  setupSite() {
    this.props.createSite(this.state.newSite);
  }

  newSiteChange(e) {
    this.setState({
      newSite: {
        ...this.state.newSite,
        [e.target.name]: e.target.value
      }
    });
  }

  render() {
    return (
      <ReactModal
        isOpen={this.props.isOpen}
        onRequestClose={() => this.props.closeModal()}
        contentLabel="Modal"
        overlayClassName="unused"
        className="c-modal c-modal--newsite is-open"
      >
        {this.getCanvasAuthForm()}
        <h2 className="c-modal__title">New Domain</h2>
        <NewSiteForm
          onChange={e => this.newSiteChange(e)}
          setupSite={() => this.setupSite()}
          closeModal={() => this.props.closeModal()}
          {...this.state.newSite}
        />
      </ReactModal>
    );
  }
}

export default connect(select, { createSite })(NewSiteModal);
