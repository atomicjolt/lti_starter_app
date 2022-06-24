import React, { useState } from 'react';
import { useSelector, useDispatch } from 'react-redux';
import Heading from '../common/heading';
import Header from './header';
import SiteModal from './modal';
import List from './list';
import { deleteSite } from '../../actions/sites';

export default function Index() {

  const [siteModalOpen, setSiteModalOpen] = useState(false);

  const sites = useSelector((state) => state.sites);
  const dispatch = useDispatch();

  const closeSiteModal = () => {
    setSiteModalOpen(false);
  };

  return (
    <div>
      <Heading />
      <div className="o-contain o-contain--full">
        <SiteModal
          isOpen={siteModalOpen}
          closeModal={() => closeSiteModal()}
        />
        <Header
          openSettings={() => {}}
          newSite={() => setSiteModalOpen(true)}
        />
        <List
          sites={sites}
          deleteSite={(siteId) => dispatch(deleteSite(siteId))}
        />
      </div>
    </div>
  );
}

Index.propTypes = {
};
