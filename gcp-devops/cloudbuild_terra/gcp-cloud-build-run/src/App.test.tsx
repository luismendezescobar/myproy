import React from 'react';
import { render, screen } from '@testing-library/react';
import App from './App';

describe('app page', () => {
  it("renders welcome message", ()=>{
    render(<App />);
    const linkElement = screen.getByText(/Welcome/i);
    expect(linkElement).toBeInTheDocument();
  })
  it("renders test message", ()=>{
    render(<App />);
    const linkElement = screen.getByText(/This is a text to be tested/i);
    expect(linkElement).toBeInTheDocument();
  })

});
