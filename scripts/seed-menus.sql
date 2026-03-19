-- =============================================================================
-- n_menus 菜单种子数据
-- 使用方式：在 Supabase Dashboard -> SQL Editor 中执行此脚本
-- 注意：若 path 已存在会报错，可先删除对应记录或修改 path
-- =============================================================================

-- 1. 插入顶级菜单
INSERT INTO public.n_menus (label, path, icon, show_in_menu, sort, parent_id)
VALUES
  ('dashboard', '/dashboard', 'layout-dashboard', true, 100, null),
  ('portfolio', '/portfolio', 'folder', true, 90, null),
  ('system-settings', '/system-settings', 'settings', true, 80, null),
  ('playground', '/playground', 'gamepad-2', true, 70, null),
  ('about', '/about', 'info', true, 10, null)
ON CONFLICT DO NOTHING;

-- 2. 插入「系统设置」子菜单
INSERT INTO public.n_menus (label, path, icon, show_in_menu, sort, parent_id)
SELECT 'user-manage', '/system-settings/user-manage', 'users', true, 2, id
FROM public.n_menus WHERE path = '/system-settings' LIMIT 1;

INSERT INTO public.n_menus (label, path, icon, show_in_menu, sort, parent_id)
SELECT 'menu-manage', '/system-settings/menu-manage', 'menu', true, 1, id
FROM public.n_menus WHERE path = '/system-settings' LIMIT 1;

-- 2.1 插入「用户管理」下的 3 级菜单 test-nested
INSERT INTO public.n_menus (label, path, icon, show_in_menu, sort, parent_id)
SELECT 'test-nested', '/system-settings/user-manage/test-nested', 'folder-tree', true, 1, id
FROM public.n_menus WHERE path = '/system-settings/user-manage' LIMIT 1;


INSERT INTO public.n_menus (label, path, icon, show_in_menu, sort, parent_id)
SELECT 'deep-level', '/system-settings/user-manage/test-nested/deep-level', 'layers', true, 0, id
FROM public.n_menus WHERE path = '/system-settings/user-manage/test-nested' LIMIT 1;

-- 3. 插入「沙盒」子菜单
INSERT INTO public.n_menus (label, path, icon, show_in_menu, sort, parent_id)
SELECT 'code-block', '/playground/code-block', 'code-2', true, 3, id
FROM public.n_menus WHERE path = '/playground' LIMIT 1;

INSERT INTO public.n_menus (label, path, icon, show_in_menu, sort, parent_id)
SELECT 'terminal', '/playground/terminal', 'terminal', true, 2, id
FROM public.n_menus WHERE path = '/playground' LIMIT 1;

INSERT INTO public.n_menus (label, path, icon, show_in_menu, sort, parent_id)
SELECT 'masonry', '/playground/masonry', 'layout-grid', true, 1, id
FROM public.n_menus WHERE path = '/playground' LIMIT 1;

-- =============================================================================
-- 若表有 path 唯一约束，首次插入后上面可能报重复错误。
-- 可改用下方「仅插入不存在的」版本（需要 PostgreSQL 支持）：
-- =============================================================================
-- INSERT INTO public.n_menus (label, path, icon, show_in_menu, sort, parent_id)
-- SELECT * FROM (VALUES
--   ('dashboard', '/dashboard', 'layout-dashboard', true, 100::int, null::uuid),
--   ...
-- ) AS v(label, path, icon, show_in_menu, sort, parent_id)
-- WHERE NOT EXISTS (SELECT 1 FROM public.n_menus m WHERE m.path = v.path);
