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

  const { ltiInstallKeys, totalPages } = useSelector((state) => state.ltiInstallKeys);
  const applications = useSelector((state) => state.applications);
  const dispatch = useDispatch();

  const application = applications[params.applicationId];

  useEffect(() => {
    dispatch(getLtiInstallKeys(
      params.applicationId,
      currentPage,
      sortColumn,
      sortDirection,
    ));
  }, []);

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

  const setSort = (sortColumnTmp, sortDirectionTmp) => {
    setSortColumn(sortColumnTmp);
    setSortDirection(sortDirectionTmp);
  };

  return (
    <div>
      <Heading />
      <div className="o-contain o-contain--full">
        <Modal
          isOpen={modalOpen}
          closeModal={() => setModalOpen(false)}
          save={(id, newLtiInstallKey) => dispatch(createLtiInstallKey(id, newLtiInstallKey))}
          application={application}
        />
        <Header
          openSettings={() => {}}
          newLtiInstallKey={() => setModalOpen(true)}
          application={application}
        />
        <List
          ltiInstallKeys={ltiInstallKeys}
          application={application}
          saveLtiInstallKey={
            (id, newLtiInstallKey) => dispatch(saveLtiInstallKey(id, newLtiInstallKey))
          }
          deleteLtiInstallKey={
            (appId, ltiInstallKeyId) => dispatch(deleteLtiInstallKey(appId, ltiInstallKeyId))
          }
          setSort={(sortColumnTmp, sortDirectionTmp) => setSort(sortColumnTmp, sortDirectionTmp)}
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
