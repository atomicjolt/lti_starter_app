import React from 'react';
import { connect } from 'react-redux';
import Heading from '../common/heading';
import Header from './header';
import SiteModal from './modal';
import List from './list';

function select(state) {
  return {
    sites: state.sites,
  };
}

export class Index extends React.Component {
  static propTypes = {
    sites: React.PropTypes.shape({}).isRequired,
  }

  constructor() {
    super();
    this.state = {
      siteModalOpen: false,
    };
  }

  closeSiteModal() {
    this.setState({
      siteModalOpen: false,
    });
  }

  render() {
    return (
      <div>
        <Heading />
        <div className="o-contain o-contain--full">
          <SiteModal
            isOpen={this.state.siteModalOpen}
            closeModal={() => this.closeSiteModal()}
          />
          <Header
            openSettings={() => {}}
            newSite={() => this.setState({ siteModalOpen: true })}
          />
          <List
            sites={this.props.sites}
          />
        </div>
      </div>
    );
  }
}

export default connect(select, {})(Index);
