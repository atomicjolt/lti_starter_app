import React from 'react';
import PropTypes from 'prop-types';
import { connect } from 'react-redux';
import _ from 'lodash';
import Header from './header';
import List from './list';
import Modal from './modal';
import Heading from '../common/heading';
import Pagination from '../common/pagination';
import * as ApplicationInstanceActions from '../../actions/application_instances';

const select = (state, props) => ({
  applicationInstances: _.filter(state.applicationInstances.applicationInstances,
    { application_id: parseInt(props.params.applicationId, 10) }),
  applications: state.applications,
  totalPages: state.applicationInstances.totalPages,
  userName: state.settings.display_name,
  settings: state.settings,
  sites: state.sites,
  canvasOauthURL: state.settings.canvas_oauth_url,
  loadingInstances: state.applicationInstances.loading
});

export class Index extends React.Component {
  static propTypes = {
    applicationInstances: PropTypes.arrayOf(PropTypes.shape({})),
    getApplicationInstances: PropTypes.func.isRequired,
    createApplicationInstance: PropTypes.func,
    deleteApplicationInstance: PropTypes.func,
    saveApplicationInstance: PropTypes.func,
    sites: PropTypes.shape({}).isRequired,
    applications: PropTypes.shape({}).isRequired,
    params: PropTypes.shape({
      applicationId: PropTypes.string.isRequired,
    }).isRequired,
    settings: PropTypes.shape({
      canvas_callback_url: PropTypes.string.isRequired,
    }).isRequired,
    canvasOauthURL: PropTypes.string.isRequired,
    disableApplicationInstance: PropTypes.func.isRequired,
    totalPages: PropTypes.number,
    loadingInstances: PropTypes.bool,
  };

  constructor() {
    super();
    this.state = {
      modalOpen: false,
      currentPage: null,
      sortColumn: 'nickname',
      sortDirection: 'asc',
      search: '',
      isSearchOpen: false,
    };
  }

  get application() {
    return this.props.applications[this.props.params.applicationId];
  }

  get newApplicationInstanceModal() {
    if (this.state.modalOpen) {
      return <Modal
        closeModal={() => this.setState({ modalOpen: false })}
        sites={this.props.sites}
        save={this.props.createApplicationInstance}
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
      search,
    } = this.state;

    this.props.getApplicationInstances(
      this.props.params.applicationId,
      currentPage,
      sortColumn,
      sortDirection,
      search,
    );
  }

  componentDidUpdate(prevProps, prevState) {
    const {
      currentPage,
      sortColumn,
      sortDirection,
      search,
    } = this.state;

    const propsChanged = (
      prevState.currentPage !== currentPage ||
      prevState.sortColumn !== sortColumn ||
      prevState.sortDirection !== sortDirection ||
      prevState.search !== search
    );

    if (propsChanged) {
      this.props.getApplicationInstances(
        this.props.params.applicationId,
        currentPage,
        sortColumn,
        sortDirection,
        search,
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

  toggleSearch= () => {
    this.setState((state) => ({
      isSearchOpen: !state.isSearchOpen
    }));
  }

  searchChanged = _.debounce((search) => {
    this.setState({ search });
  }, 500);

  resetSort() {
    this.setState({
      sortColumn: 'nickname',
      sortDirection: 'asc',
      currentPage: 0,
    });
  }

  render() {
    const { application } = this;

    const {
      sortColumn:currentSortColumn,
      sortDirection:currentSortDirection,
      isSearchOpen,
      currentPage,
    } = this.state;

    const {
      applicationInstances,
      settings,
      sites,
      saveApplicationInstance,
      deleteApplicationInstance,
      disableApplicationInstance,
      canvasOauthURL,
      loadingInstances,
      totalPages,
    } = this.props;

    return (
      <div>
        <Heading
          backTo="/applications"
          application={application}
        />
        <div className="o-contain o-contain--full">
          {this.newApplicationInstanceModal}
          <Header
            openSettings={() => {}}
            newApplicationInstance={() => this.setState({ modalOpen: true })}
            application={application}
            applicationInstances={applicationInstances}
          />
          <List
            applicationInstances={applicationInstances}
            settings={settings}
            sites={sites}
            application={application}
            saveApplicationInstance={saveApplicationInstance}
            deleteApplicationInstance={deleteApplicationInstance}
            disableApplicationInstance={disableApplicationInstance}
            canvasOauthURL={canvasOauthURL}
            setSort={(sortColumn, sortDirection) => this.setSort(sortColumn, sortDirection)}
            searchChanged={(search) => this.searchChanged(search)}
            currentSortColumn={currentSortColumn}
            currentSortDirection={currentSortDirection}
            isSearchOpen={isSearchOpen}
            toggleSearch={this.toggleSearch}
            loadingInstances={loadingInstances}
          />
          <Pagination
            setPage={(change) => this.setPage(change)}
            pageCount={totalPages}
            currentPage={currentPage}
            disableInitialCallback
          />
        </div>
      </div>
    );
  }
}

export default connect(select, ApplicationInstanceActions)(Index);
