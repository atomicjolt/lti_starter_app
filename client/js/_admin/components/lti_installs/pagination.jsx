import React         from 'react';
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
  setPage: React.PropTypes.func.isRequired,
  pageCount: React.PropTypes.number.isRequired,
  courses: React.PropTypes.arrayOf(React.PropTypes.shape({})),
  pageSize: React.PropTypes.number
};
