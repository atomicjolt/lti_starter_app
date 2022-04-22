import React from 'react';
import { Route } from 'react-router';
import Errors from '../../../../common/components/common/errors';
import Home from '../home';

export default function Index() {
  return (
    <div className="app-index">
      <Errors />
      <Route exact path="/" component={Home} />
    </div>
  );
}
