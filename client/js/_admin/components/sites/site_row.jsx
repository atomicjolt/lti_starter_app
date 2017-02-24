import React from 'react';
import SiteModal from './modal';
import DeleteSiteModal from './delete_modal';

export default class SiteRow extends React.Component {

  static propTypes = {
    site: React.PropTypes.shape({
      url: React.PropTypes.string,
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
    return (
      <tr>
        <td>
          {this.props.site.url}
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
