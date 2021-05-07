import React from 'react';
import PropTypes from 'prop-types';
import { connect } from 'react-redux';
import _ from 'lodash';
import Header from './header';
import List from './list';
import PaidTabs from './paid_tabs';
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
      showPaid: true,
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
      showPaid,
      search,
    } = this.state;

    this.props.getApplicationInstances(
      this.props.params.applicationId,
      currentPage,
      sortColumn,
      sortDirection,
      showPaid.toString(),
      search,
    );
  }

  componentDidMount() {
    window.addEventListener('click', this.closeMenus);
  }

  componentWillUnmount() {
    window.removeEventListener('click', this.closeMenus);
  }

  closeMenus = () => {
    window.dispatchEvent(new CustomEvent('close-menu'));
  }

  componentDidUpdate(prevProps, prevState) {
    const {
      currentPage,
      sortColumn,
      sortDirection,
      showPaid,
      search,
    } = this.state;

    const propsChanged = (
      prevState.currentPage !== currentPage ||
      prevState.sortColumn !== sortColumn ||
      prevState.sortDirection !== sortDirection ||
      prevState.showPaid !== showPaid ||
      prevState.search !== search
    );

    if (propsChanged) {
      this.props.getApplicationInstances(
        this.props.params.applicationId,
        currentPage,
        sortColumn,
        sortDirection,
        showPaid.toString(),
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
      showPaid: true,
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
      showPaid,
      isSearchOpen
    } = this.state;

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
            applicationInstances={this.props.applicationInstances}
          />
          <PaidTabs
            changeTab={(tab) => {
              tab ? this.resetSort() : this.setState({ showPaid: tab, sortDirection: 'asc' });
            }}
            showPaid={showPaid}
          />
          <List
            applicationInstances={this.props.applicationInstances}
            settings={this.props.settings}
            sites={this.props.sites}
            application={application}
            saveApplicationInstance={this.props.saveApplicationInstance}
            deleteApplicationInstance={this.props.deleteApplicationInstance}
            disableApplicationInstance={this.props.disableApplicationInstance}
            canvasOauthURL={this.props.canvasOauthURL}
            setSort={(sortColumn, sortDirection) => this.setSort(sortColumn, sortDirection)}
            searchChanged={(search) => this.searchChanged(search)}
            currentSortColumn={currentSortColumn}
            currentSortDirection={currentSortDirection}
            showPaid={showPaid}
            isSearchOpen={isSearchOpen}
            toggleSearch={this.toggleSearch}
            loadingInstances={this.props.loadingInstances}
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

export default connect(select, ApplicationInstanceActions)(Index);
