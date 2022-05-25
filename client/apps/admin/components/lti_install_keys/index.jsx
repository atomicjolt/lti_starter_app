import React, { useState, useEffect } from 'react';
import PropTypes from 'prop-types';
import { useSelector, useDispatch } from 'react-redux';
import Header from './header';
import List from './list';
import Modal from './modal';
import Heading from '../common/heading';
import Pagination from '../common/pagination';
import {
  getLtiInstallKeys, createLtiInstallKey, deleteLtiInstallKey, saveLtiInstallKey
} from '../../actions/lti_install_keys';

export default function Index(props) {
  const {
    params,
  } = props;

  const [modalOpen, setModalOpen] = useState(false);
  const [currentPage, setCurrentPage] = useState(null);
  const [sortColumn, setSortColumn] = useState('created_at');
  const [sortDirection, setSortDirection] = useState('desc');

  const ltiInstallKeys = useSelector((state) => state.ltiInstallKeys);
  const applications = useSelector((state) => state.applications);
  const totalPages = useSelector((state) => state.ltiInstallKeys.totalPages);
  const dispatch = useDispatch();

  const application = applications[params.applicationId];

  const newLtiInstallKeyModal = () => {
    if (modalOpen) {
      return <Modal
        closeModal={() => setModalOpen(false)}
        save={createLtiInstallKey}
        application={application}
      />;
    }
    return null;
  };

  useEffect(() => {
    dispatch(getLtiInstallKeys(
      params.applicationId,
      currentPage,
      sortColumn,
      sortDirection,
    ));
  });

  useEffect(() => {
    dispatch(getLtiInstallKeys(
      params.applicationId,
      currentPage,
      sortColumn,
      sortDirection,
    ));
  }, [currentPage, sortColumn, sortDirection]);

  const setPage = (change) => {
    setCurrentPage(change.selected + 1);
  };

  const setSort = () => {
    setSortColumn(sortColumn);
    setSortDirection(sortDirection);
  };

  return (
    <div>
      <Heading />
      <div className="o-contain o-contain--full">
        {newLtiInstallKeyModal}
        <Header
          openSettings={() => {}}
          newLtiInstallKey={() => setModalOpen(true)}
          application={application}
        />
        <List
          ltiInstallKeys={ltiInstallKeys}
          application={application}
          saveLtiInstallKey={
            saveLtiInstallKey
          }
          deleteLtiInstallKey={
            deleteLtiInstallKey
          }
          setSort={() => setSort(sortColumn, sortDirection)}
          currentSortColumn={sortColumn}
          currentSortDirection={sortDirection}
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
  applications: PropTypes.shape({}).isRequired,
  params: PropTypes.shape({
    applicationId: PropTypes.string.isRequired,
  }).isRequired,
};
