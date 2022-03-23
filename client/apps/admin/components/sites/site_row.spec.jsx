import React from 'react';
import TestRenderer from 'react-test-renderer';
import { Provider } from 'react-redux';
import configureStore from 'redux-mock-store';

import SiteRow from './site_row';

const mockStore = configureStore([]);
const store = mockStore({
  settings: {},
});

describe('sites list row', () => {
  let result;
  let instance;
  let props;

  beforeEach(() => {
    props = {
      site: { url: 'http://www.example.com' },
      deleteSite: () => {},
    };
    result = TestRenderer.create(
      <Provider store={store}>
        <SiteRow {...props} />
      </Provider>
    );
    instance = result.root;
  });

  it('matches the snapshot', () => {
    expect(result).toMatchSnapshot();
  });

  it('handles the first button onclick event', () => {
    expect(result).toMatchSnapshot();
    const buttons = instance.findAllByType('button');
    buttons[0].props.onClick();
    expect(result).toMatchSnapshot();
  });

  it('handles the second button onclick event', () => {
    const buttons = instance.findAllByType('button');
    expect(result.root.state.confirmDeleteModalOpen).toBeFalsy();
    buttons[1].props.onClick();
    expect(result.root.state.confirmDeleteModalOpen).toBeTruthy();
  });
});
