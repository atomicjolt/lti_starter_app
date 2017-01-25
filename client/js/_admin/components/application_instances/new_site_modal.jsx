import React          from 'react';
import { connect }    from 'react-redux';
import ReactModal     from 'react-modal';
import SettingsInputs from '../common/settings_inputs';

const select = state => ({
  settings: state.settings
});

export class NewSiteModal extends React.Component {
  static propTypes = {
    isOpen: React.PropTypes.bool.isRequired,
    closeModal: React.PropTypes.func.isRequired,
    settings: React.PropTypes.shape({
      lti_key: React.PropTypes.string
    })
  };

  render() {
    return (
      <ReactModal
        isOpen={this.props.isOpen}
        onRequestClose={() => this.props.closeModal()}
        contentLabel="Modal"
        overlayClassName="unused"
        className="c-modal c-modal--newsite is-open"
      >
        <h2 className="c-modal__title">New Domain</h2>
        <form action="/users/auth/canvas">
          <SettingsInputs settings={this.props.settings} />
          <div className="o-grid o-grid__modal-top">
            <div className="o-grid__item u-half">
              <label htmlFor="canvas_developer_id" className="c-input">
                <span>Canvas Developer ID</span>
                <input name="canvas_developer_id" type="text" />
              </label>
            </div>
            <div className="o-grid__item u-half">
              <label htmlFor="canvas_developer_key" className="c-input">
                <span>Canvas Developer Key</span>
                <input name="canvas_developer_key" type="text" />
              </label>
            </div>
            <div className="o-grid__item u-half">
              <label htmlFor="canvas_url" className="c-input">
                <span>Canvas Domain</span>
                <input name="canvas_url" type="text" />
              </label>
            </div>
          </div>

          <button type="submit" className="c-btn c-btn--yellow">Authenticate</button>
          <button
            type="button"
            className="c-btn c-btn--gray--large u-m-right"
            onClick={() => this.props.closeModal()}
          >
            Cancel
          </button>
        </form>
      </ReactModal>
    );
  }
}

export default connect(select)(NewSiteModal);
