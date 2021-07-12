import React from 'react';
import PropTypes from 'prop-types';
import { connect } from 'react-redux';
import _ from 'lodash';
import Header from './header';
import List from './list';
import Modal from './modal';
import Heading from '../common/heading';
import Pagination from '../common/pagination';
import * as LtiInstallKeyActions from '../../actions/lti_install_keys';

const select = (state, props) => ({
  ltiInstallKeys: _.filter(state.ltiInstallKeys.ltiInstallKeys,
    { application_id: parseInt(props.params.applicationId, 10) }),
  applications: state.applications,
  totalPages: state.ltiInstallKeys.totalPages,
});

export class Index extends React.Component {
  static propTypes = {
    ltiInstallKeys: PropTypes.arrayOf(PropTypes.shape({})),
    getLtiInstallKeys: PropTypes.func.isRequired,
    createLtiInstallKey: PropTypes.func,
    deleteLtiInstallKey: PropTypes.func,
    saveLtiInstallKey: PropTypes.func,
    applications: PropTypes.shape({}).isRequired,
    params: PropTypes.shape({
      applicationId: PropTypes.string.isRequired,
    }).isRequired,
    totalPages: PropTypes.number,
  };

  constructor() {
    super();
    this.state = {
      modalOpen: false,
      currentPage: null,
      sortColumn: 'created_at',
      sortDirection: 'desc',
    };
  }

  get application() {
    return this.props.applications[this.props.params.applicationId];
  }

  get newLtiInstallKeyModal() {
    const {
      modalOpen,
    } = this.state;

    if (modalOpen) {
      const {
        createLtiInstallKey,
      } = this.props;

      return <Modal
        closeModal={() => this.setState({ modalOpen: false })}
        save={createLtiInstallKey}
        application={this.application}
      />;
    }
    return null;
  }

  componentWillMount() {
    const {
      currentPage,
      sortColumn,
      sortDirection,
    } = this.state;

    this.props.getLtiInstallKeys(
      this.props.params.applicationId,
      currentPage,
      sortColumn,
      sortDirection,
    );
  }

  componentDidUpdate(prevProps, prevState) {
    const {
      currentPage,
      sortColumn,
      sortDirection,
    } = this.state;

    const propsChanged = (
      prevState.currentPage !== currentPage ||
      prevState.sortColumn !== sortColumn ||
      prevState.sortDirection !== sortDirection
    );

    if (propsChanged) {
      this.props.getLtiInstallKeys(
        this.props.params.applicationId,
        currentPage,
        sortColumn,
        sortDirection,
      );
    }
  }

  setPage(change) {
    this.setState({ currentPage: change.selected + 1 });
  }

  setSort(sortColumn, sortDirection) {
    this.setState({
      sortColumn,
      sortDirection,
    });
  }

  render() {
    const { application } = this;

    const {
      sortColumn:currentSortColumn,
      sortDirection:currentSortDirection,
    } = this.state;

    return (
      <div>
        <Heading />
        <div className="o-contain o-contain--full">
          {this.newLtiInstallKeyModal}
          <Header
            openSettings={() => {}}
            newLtiInstallKey={() => this.setState({ modalOpen: true })}
            application={application}
          />
          <List
            ltiInstallKeys={this.props.ltiInstallKeys}
            application={application}
            saveLtiInstallKey={this.props.saveLtiInstallKey}
            deleteLtiInstallKey={this.props.deleteLtiInstallKey}
            setSort={(sortColumn, sortDirection) => this.setSort(sortColumn, sortDirection)}
            currentSortColumn={currentSortColumn}
            currentSortDirection={currentSortDirection}
          />
          <Pagination
            setPage={change => this.setPage(change)}
            pageCount={this.props.totalPages}
            currentPage={this.state.currentPage}
            disableInitialCallback
          />
        </div>
      </div>
    );
  }
}

export default connect(select, LtiInstallKeyActions)(Index);
