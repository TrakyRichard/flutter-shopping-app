module.exports = ({ env }) => ({
  host: env('HOST', '0.0.0.0'),
  port: env.int('PORT', 4242),
  admin: {
    auth: {
      secret: env('ADMIN_JWT_SECRET', 'a3a4f327f6478a8c2f5676cf0fa2d054'),
    },
  },
});
