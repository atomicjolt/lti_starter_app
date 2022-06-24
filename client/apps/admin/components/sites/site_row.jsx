import _ from 'lodash';
import React, { useState } from 'react';
import PropTypes from 'prop-types';
import SiteModal from './modal';
import DeleteModal from '../common/delete_modal';

export default function SiteRow(props) {
  const {
    deleteSite: delSite,
    site,
  } = props;

  const [siteModalOpen, setSiteModalOpen] = useState(false);
  const [confirmDeleteModalOpen, setConfirmDeleteModalOpen] = useState(false);

  const getStyles = () => ({
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
  });

  const closeSiteModal = () => {
    setSiteModalOpen(false);
  };

  const closeDeleteModal = () => {
    setConfirmDeleteModalOpen(false);
  };

  const deleteSite = (siteId) => {
    setConfirmDeleteModalOpen(false);

    delSite(siteId);
  };

  const styles = getStyles();
  let warning = null;
  if (_.isEmpty(site.oauth_key) || _.isEmpty(site.oauth_secret)) {
    warning = (
      <span className="c-alert c-alert--danger" style={styles.alertStyle}>
        OAuth key and/or secret not configured
      </span>
    );
  }
  return (
    <tr>
      <td>
        {site.url}
        {warning}
      </td>
      <td>
        <button
          type="button"
          style={styles.buttonIcon}
          onClick={() => setSiteModalOpen(true)}
        >
          <i className="material-icons">settings</i>
        </button>
        <SiteModal
          site={site}
          isOpen={siteModalOpen}
          closeModal={() => closeSiteModal()}
        />
      </td>
      <td>
        <button
          type="button"
          style={styles.buttonIcon}
          onClick={() => setConfirmDeleteModalOpen(true)}
        >
          <i className="i-delete" />
        </button>
        <DeleteModal
          deleteRecord={() => deleteSite(site.id)}
          isOpen={confirmDeleteModalOpen}
          closeModal={() => closeDeleteModal()}
        />
      </td>
    </tr>
  );

}

SiteRow.propTypes = {
  site: PropTypes.shape({
    url: PropTypes.string,
    oauth_key: PropTypes.string,
    oauth_secret: PropTypes.string,
  }).isRequired,
  deleteSite: PropTypes.func.isRequired,
};
