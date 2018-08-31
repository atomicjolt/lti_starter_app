import React from 'react';
import PropTypes from 'prop-types';
import ReactPaginate from 'react-paginate';

export default function Pagination(props) {
  if (props.pageCount === 1) {
    return null;
  }

  const disableInitialCallback = props.disableInitialCallback || false;

  return (
    <ReactPaginate
      previousLabel="Prev"
      containerClassName="pagination"
      pageCount={props.pageCount}
      pageRangeDisplayed={5}
      marginPagesDisplayed={1}
      onPageChange={props.setPage}
      initialPage={props.currentPage}
      disableInitialCallback={disableInitialCallback}
    />
  );
}

Pagination.propTypes = {
  setPage: PropTypes.func.isRequired,
  pageCount: PropTypes.number.isRequired,
  currentPage: PropTypes.number,
  disableInitialCallback: PropTypes.bool,
};
