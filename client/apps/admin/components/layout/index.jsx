import React, { useEffect } from 'react';
import PropTypes from 'prop-types';
import { useDispatch } from 'react-redux';
import { getApplications } from '../../actions/applications';
import { getSites } from '../../actions/sites';
import appHistory from '../../history';
import Errors from '../../../../common/components/common/errors';

export default function Index(props) {
  const dispatch = useDispatch();
  const { location, children } = props;

  useEffect(() => {
    dispatch(getApplications());
    dispatch(getSites());
  }, []);

  useEffect(() => {
    if (location.pathname === '/') {
      appHistory.replace('/applications');
    }
  }, [location.pathname]);

  return (
    <div className="app-index">
      <Errors />
      {children}
    </div>
  );
}

Index.defaultProps = {
  children: '',
};

Index.propTypes = {
  children: PropTypes.node,
  location: PropTypes.shape({
    pathname: PropTypes.string,
  }),
};
