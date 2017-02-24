import React from 'react';
import { Link } from 'react-router';

const SubNav = () => (
  <div className="c-subnav">
    <ul>
      <li>
        <Link to="/applications" activeClassName="is-active">LTI Tools</Link>
      </li>
      <li>
        <Link to="/sites" activeClassName="is-active">Sites</Link>
      </li>
    </ul>
  </div>
);

export default SubNav;
