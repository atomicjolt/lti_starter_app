import React from 'react';
import PropTypes from 'prop-types';
import { Link } from 'react-router3';
import _ from 'lodash';

export default function NavColumn(props) {

  const {
    location,
    application,
    applicationInstance,
  } = props;

  const path = `/applications/${application.id}/application_instances/${applicationInstance.id}/settings`;
  const currentPath = location.pathname;

  const tabs = [
    {
      name: 'Overview',
      iconClass: 'far fa-analytics',
      selected: currentPath === `${path}/analytics` || currentPath === path,
      route: `${path}/analytics`,
    },
    {
      name: 'General Settings',
      iconClass: 'far fa-edit',
      selected: currentPath === `${path}/generalSettings`,
      route: `${path}/generalSettings`,
    },
    {
      name: 'Configuration',
      iconClass: 'far fa-cog',
      selected: currentPath === `${path}/configuration`,
      route: `${path}/configuration`,
    },
    {
      name: 'License Details',
      iconClass: 'far fa-file-invoice-dollar',
      selected: currentPath === `${path}/licenseDetails`,
      route: `${path}/licenseDetails`,
    },
    {
      name: 'Trial Details',
      iconClass: 'far fa-clipboard',
      selected: currentPath === `${path}/trialDetails`,
      route: `${path}/trialDetails`,
    },
  ];

  return (
    <div className="nav-col">
      {_.map(tabs, (tab, index) => (
        <Link key={index} to={tab.route} className={`tabs ${tab.selected && 'active'}`}>
          <i className={`${tab.iconClass} icon`} />
          <p className="text">
            {tab.name}
          </p>
        </Link>
      ))}
    </div>
  );
}

NavColumn.propTypes = {
  location: PropTypes.shape({
    pathname: PropTypes.string
  }),
  application: PropTypes.shape({
    id: PropTypes.number
  }),
  applicationInstance: PropTypes.shape({
    id: PropTypes.number
  }),
};
