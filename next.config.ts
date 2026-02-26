import type { NextConfig } from "next";
import createNextIntlPlugin from 'next-intl/plugin';

const withNextIntl = createNextIntlPlugin();

const nextConfig: NextConfig = {
  typescript: {
    ignoreBuildErrors: true,
  },
  images: {
    remotePatterns: [new URL('https://cdn.simpleicons.org/**'), new URL('https://cdn.baiwumm.com/**')],
    unoptimized: true, // 禁用 Vercel 图片优化
  },
};

export default withNextIntl(nextConfig);
