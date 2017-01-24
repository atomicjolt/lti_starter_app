import React       from 'react';
import { connect } from 'react-redux';
import ReactModal  from 'react-modal';

const select = state => ({
  settings: state.settings
});

export class NewDomainModal extends React.Component {
  static propTypes = {
    isOpen: React.PropTypes.bool.isRequired,
    closeModal: React.PropTypes.func.isRequired,
    settings: React.PropTypes.shape({
      canvas_oauth_path: React.PropTypes.string
    })
  };

  renderSettings(){
    return _.map(this.props.settings, (value, key) => {
      return (<input key={key} type="hidden" value={value} name={key} />);
    });
  }

  render() {
    return (
      <ReactModal
        isOpen={this.props.isOpen}
        onRequestClose={() => this.props.closeModal()}
        contentLabel="Modal"
        overlayClassName="unused"
        className="c-modal c-modal--newdomain is-open"
      >
        <h2 className="c-modal__title">New Domain</h2>
        <form action="/users/auth/canvas">
          <input type="hidden" name="oauth_consumer_key" value="admin" />
          { this.renderSettings() }
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

export default connect(select)(NewDomainModal);
