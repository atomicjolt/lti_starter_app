import _ from 'lodash';
import React from 'react';
import PropTypes from 'prop-types';
import SiteModal from './modal';
import DeleteSiteModal from './delete_modal';

export default class SiteRow extends React.Component {

  static propTypes = {
    site: PropTypes.shape({
      url: PropTypes.string,
      oauth_key: PropTypes.string,
      oauth_secret: PropTypes.string,
    }).isRequired,
  };

  static getStyles() {
    return {
      buttonIcon: {
        border: 'none',
        backgroundColor: 'transparent',
        color: 'grey',
        fontSize: '1.5em',
        cursor: 'pointer',
      },
      alertStyle: {
        fontSize: '10px'
      }
    };
  }

  constructor() {
    super();
    this.state = {
      siteModalOpen: false,
      confirmDeleteModalOpen: false,
    };
  }

  closeSiteModal() {
    this.setState({
      siteModalOpen: false,
    });
  }

  closeDeleteModal() {
    this.setState({
      confirmDeleteModalOpen: false,
    });
  }

  render() {
    const styles = SiteRow.getStyles();
    let warning = null;
    if (_.isEmpty(this.props.site.oauth_key) || _.isEmpty(this.props.site.oauth_secret)) {
      warning = (
        <span className="c-alert c-alert--danger" style={styles.alertStyle}>
          OAuth key and/or secret not configured
        </span>
      );
    }
    return (
      <tr>
        <td>
          {this.props.site.url}
          {warning}
        </td>
        <td>
          <button
            style={styles.buttonIcon}
            onClick={() => this.setState({ siteModalOpen: true })}
          >
            <i className="i-settings" />
          </button>
          <SiteModal
            site={this.props.site}
            isOpen={this.state.siteModalOpen}
            closeModal={() => this.closeSiteModal()}
          />
        </td>
        <td>
          <button
            style={styles.buttonIcon}
            onClick={() => this.setState({ confirmDeleteModalOpen: true })}
          >
            <i className="i-delete" />
          </button>
          <DeleteSiteModal
            site={this.props.site}
            isOpen={this.state.confirmDeleteModalOpen}
            closeModal={() => this.closeDeleteModal()}
          />
        </td>
      </tr>
    );
  }

}
