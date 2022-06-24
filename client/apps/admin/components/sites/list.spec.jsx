import React from 'react';
import TestRenderer from 'react-test-renderer';
import { Provider } from 'react-redux';
import configureStore from 'redux-mock-store';
import List from './list';

const mockStore = configureStore([]);
const store = mockStore({
  settings: {
    canvas_callback_url: 'https://www.example.com',
  },
});

describe('sites list', () => {
  let result;
  let instance;

  const sites = {
    1: {
      id: 1,
      url: 'bfcoder.com'
    },

    2: {
      id: 2,
      url: 'atomicjolt.com'
    }
  };

  const deleteSite = () => {};

  beforeEach(() => {
    result = TestRenderer.create(
      <Provider store={store}>
        <List
          sites={sites}
          deleteSite={deleteSite}
        />
      </Provider>
    );
    instance = result.root;
  });

  it('matches the snapshot', () => {
    expect(result).toMatchSnapshot();
  });

  it('renders the list with header values', () => {
    const thead = instance.findByType('thead');
    const headings = thead.props.children.props.children;
    expect(headings.length).toEqual(3);
    expect(headings[0].type).toEqual('th');
    const spans = thead.findAllByType('span');
    expect(spans[0].props.children).toEqual('URL');
    expect(spans[1].props.children).toEqual('SETTINGS');
    expect(spans[2].props.children).toEqual('DELETE');
  });
});
