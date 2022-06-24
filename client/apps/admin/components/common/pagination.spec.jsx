import React from 'react';
import TestRenderer from 'react-test-renderer';
import Pagination from './pagination';

describe('lti installs pagination', () => {
  let result;
  let props;

  beforeEach(() => {
    props = {
      setPage: () => {},
      pageCount: 21,
      currentPage: 2
    };
    result = TestRenderer.create(<Pagination {...props} />);
  });

  it('renders', () => {
    expect(result).toBeDefined();
  });

  it('renders the form not null', () => {
    expect(result).not.toBeNull();
  });
});
