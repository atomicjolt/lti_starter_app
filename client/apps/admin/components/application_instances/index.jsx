import React, { useState, useEffect } from 'react';
import PropTypes from 'prop-types';
import { useSelector, useDispatch } from 'react-redux';
import _ from 'lodash';
import Header from './header';
import List from './list';
import Modal from './modal';
import Heading from '../common/heading';
import Pagination from '../common/pagination';
import {
  getApplicationInstances,
  createApplicationInstance,
} from '../../actions/application_instances';

export default function Index(props) {
  const {
    params,
  } = props;

  const [modalOpen, setModalOpen] = useState(false);
  const [currentPage, setCurrentPage] = useState(null);
  const [sortColumn, setSortColumn] = useState('nickname');
  const [sortDirection, setSortDirection] = useState('asc');
  const [search, setSearch] = useState('');
  const [isSearchOpen, setIsSearchOpen] = useState(false);
  const dispatch = useDispatch();

  const applicationInstances = useSelector((state) => _.filter(
    state.applicationInstances.applicationInstances,
    { application_id: parseInt(params.applicationId, 10) }));
  const applications = useSelector((state) => state.applications);
  const totalPages = useSelector((state) => state.applicationInstances.totalPages);
  const sites = useSelector((state) => state.sites);
  const loadingInstances = useSelector((state) => state.applicationInstances.loading);

  const application = () => applications[params.applicationId];

  const newApplicationInstanceModal = () => {
    if (modalOpen) {
      return <Modal
        closeModal={() => setModalOpen(false)}
        sites={sites}
        save={createApplicationInstance}
        application={application}
      />;
    }
    return null;
  };

  useEffect(() => {
    dispatch(getApplicationInstances(
      params.applicationId,
      currentPage,
      sortColumn,
      sortDirection,
      search
    ));
  });

  useEffect(() => {
    dispatch(getApplicationInstances(
      params.applicationId,
      currentPage,
      sortColumn,
      sortDirection,
      search
    ));
  }, [currentPage, sortColumn, sortDirection, search]);

  const setPage = (change) => {
    setCurrentPage(change.selected + 1);
  };

  const setSort = (sortColumnTmp, sortDirectionTmp) => {
    setSortColumn(sortColumnTmp);
    setSortDirection(sortDirectionTmp);
  };

  const toggleSearch = () => {
    setIsSearchOpen(!isSearchOpen);
  };

  const searchChanged = _.debounce((searchTmp) => {
    setSearch(searchTmp);
  }, 500);

  return (
    <div>
      <Heading
        backTo="/applications"
        application={application}
      />
      <div className="o-contain o-contain--full">
        {newApplicationInstanceModal}
        <Header
          openSettings={() => {}}
          newApplicationInstance={() => setModalOpen(true)}
          application={application}
          applicationInstances={applicationInstances}
        />
        <List
          applicationInstances={applicationInstances}
          application={application}
          setSort={(sortColumnTmp, sortDirectionTmp) => setSort(sortColumnTmp, sortDirectionTmp)}
          searchChanged={(searchTmp) => searchChanged(searchTmp)}
          currentSortColumn={sortColumn}
          currentSortDirection={sortDirection}
          isSearchOpen={isSearchOpen}
          toggleSearch={toggleSearch}
          loadingInstances={loadingInstances}
        />
        <Pagination
          setPage={(change) => setPage(change)}
          pageCount={totalPages}
          currentPage={currentPage}
          disableInitialCallback
        />
      </div>
    </div>
  );
}

Index.propTypes = {
  params: PropTypes.shape({
    applicationId: PropTypes.string.isRequired,
  }).isRequired,
};
