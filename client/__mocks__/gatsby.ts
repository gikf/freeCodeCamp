import React from 'react';
import type { GatsbyLinkProps } from 'gatsby';
import { vi } from 'vitest';
import gatsby from 'gatsby';

import envData from '../config/env.json';
const { clientLocale } = envData;

 const navigate = vi.fn();
 const graphql = vi.fn();
 const Link = vi
  .fn()
  .mockImplementation(({ to, ...rest }: GatsbyLinkProps<undefined | boolean>) =>
    React.createElement('a', { ...rest, href: to })
  
 const withPrefix = vi.fn().mockImplementation((path: string) => 
  const pathPrefix = clientLocale === 'english' ? '' : '/' + clientLocale;
  return pathPrefix + path;

 const StaticQuery = vi.fn()
 const useStaticQuery = vi.fn()

         
     gatsby,
  navigate,
  graphql,
  Link,
  withPrefix,
  StaticQuery,
  useStaticQuery

