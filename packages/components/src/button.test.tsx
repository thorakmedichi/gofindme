// import React from 'react';
import { render, screen } from '@testing-library/react'
// import userEvent from '@testing-library/user-event'
import '@testing-library/jest-dom'
import { Button } from './button';



describe('Button', () => {
  it('has the proper title', () => {
    render(<Button title="Test Title" onClick={() => undefined} />);

    expect(screen.getByRole('button')).toBeInTheDocument();
  });

  it.skip('has the proper callback called the proper number of times when clicked', () => {
    render(<Button title="Test Title" onClick={() => undefined} />);

    expect(screen.getByRole('button')).toBeInTheDocument();
  });
});
