import React from 'react';
import PropTypes from 'prop-types';
import ReactPaginate from 'react-paginate';

export default function Pagination(props) {
  if (props.courses.length < props.pageSize) return null;

  return (
    <ReactPaginate
      previousLabel="Prev"
      containerClassName="pagination"
      pageCount={props.pageCount}
      pageRangeDisplayed={5}
      marginPagesDisplayed={1}
      onPageChange={props.setPage}
      initialPage={props.currentPage}
    />
  );
}

Pagination.propTypes = {
  setPage: PropTypes.func.isRequired,
  pageCount: PropTypes.number.isRequired,
  courses: PropTypes.arrayOf(PropTypes.shape({})),
  pageSize: PropTypes.number,
  currentPage: PropTypes.number
};
