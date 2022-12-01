import React from 'react';
import PropTypes from 'prop-types';
import _ from 'lodash';
import { Link } from 'react-router3';
import Menu from './menu';
import SubNav from './sub_nav';
import logo from '../../assets/images/aj-logo-emblem.svg';
import { useDispatch, useSelector } from 'react-redux'

export default function Heading(props) {
  const {
    application,
  } = props;

  const dispatch = useDispatch();
  const signOutUrl = useSelector((state) => state.settings.sign_out_url);
  const userEditUrl = useSelector((state) => state.settings.user_edit_url);
  const usersUrl = useSelector((state) => state.settings.users_url);
  const sites = useSelector((state) => state.sites);
  const journalsAdminUrl = useSelector((state) => state.settings.journals_admin_url);
  const poolsAdminUrl = useSelector((state) => state.settings.polls_admin_url);
  const discussionsAdminUrl = useSelector((state) => state.settings.discussions_admin_url);
  const assessmentsAdminUrl = useSelector((state) => state.settings.assessments_admin_url);
  const searchAdminUrl = useSelector((state) => state.settings.search_admin_url);
  const actAdminUrl = useSelector((state) => state.settings.act_admin_url);

  const apps = [
    {
      displayName: 'Starter',
      title: 'Starter App',
      link: '',
    },
  ];

  return (
    <div>
      <header className="c-head">
        <div className="aj-flex">
          <img className="c-head-img" src={logo} alt="Atomic Jolt Logo" />
          <nav className="c-head-nav">
            { _.map(apps, (app, key) => (
              <Link key={app.title + key} href={app.link} className="c-head-link" aria-selected={app.title === application ? application.name : null}>
                {app.displayName}
              </Link>
            ))}
          </nav>
        </div>
        <div className="c-head-profile">
          <Menu>
            {(onClick, activeClass, isOpen, menuRef) => (
              <div className={`aj-menu-contain aj-menu-space ${activeClass}`} ref={menuRef}>
                <button
                  className="aj-icon-btn"
                  aria-label="Analytics Options"
                  aria-haspopup="true"
                  aria-expanded={isOpen ? 'true' : 'false'}
                  onClick={onClick}
                  type="button"
                >
                  <i className="material-icons-outlined" aria-hidden="true">account_circle</i>
                </button>
                <ul className="aj-menu" role="menu">
                  <li>
                    <a href={usersUrl}><span>Admin Users</span></a>
                  </li>
                  <li>
                    <a href={userEditUrl}><span>Update Profile</span></a>
                  </li>
                  <li>
                    <a href={signOutUrl}><span>Logout</span></a>
                  </li>
                  <li>
                    <a href={`${signOutUrl}?destroy_authentications=true`}>
                      <span>Delete Canvas Authentications and Sign Out</span>
                    </a>
                  </li>
                </ul>
              </div>
            )}
          </Menu>
        </div>
      </header>
      <div className="c-yellow-bar" />
      <SubNav sites={sites} />
    </div>
  );
}

Heading.propTypes = {
  signOutUrl: PropTypes.string.isRequired,
  userEditUrl: PropTypes.string,
  usersUrl: PropTypes.string,
  sites: PropTypes.shape({}).isRequired,
  application: PropTypes.shape({
    name: PropTypes.string,
  }),
  applications: PropTypes.shape({}),
  journalsAdminUrl: PropTypes.string,
  assessmentsAdminUrl: PropTypes.string,
  searchAdminUrl: PropTypes.string,
  poolsAdminUrl: PropTypes.string,
  discussionsAdminUrl: PropTypes.string,
  actAdminUrl: PropTypes.string,
};
