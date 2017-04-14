import React from 'react';
import { connect } from 'react-redux';
import ReactModal from 'react-modal';

import DeleteSiteForm from './delete_form';
import { deleteSite } from '../../actions/sites';

const select = () => ({});

export class SiteModal extends React.Component {
  static propTypes = {
    site: React.PropTypes.shape({
      id: React.PropTypes.number,
    }).isRequired,
    deleteSite: React.PropTypes.func.isRequired,
    isOpen: React.PropTypes.bool.isRequired,
    closeModal: React.PropTypes.func.isRequired,
  };

  constructor(props) {
    super(props);
    this.state = {
      site: props.site,
    };
  }

  componentWillReceiveProps(nextProps) {
    this.setState({
      site: nextProps.site,
    });
  }

  render() {
    return (
      <ReactModal
        isOpen={this.props.isOpen}
        onRequestClose={() => this.props.closeModal()}
        contentLabel="Modal"
        overlayClassName="unused"
        className="c-modal c-modal--site is-open"
      >
        <h2 className="c-modal__title">Are you sure?</h2>
        <DeleteSiteForm
          deleteSite={() => this.props.deleteSite(this.props.site.id)}
          closeModal={() => this.props.closeModal()}
        />
      </ReactModal>
    );
  }
}

export default connect(select, { deleteSite })(SiteModal);
