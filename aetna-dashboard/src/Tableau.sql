SELECT t.Rule_ID,
       t.Question,
       t.Query,
       t.Insight,
       t.Dashboard,
       t.TeamS,
       t.Last_Update_dt
FROM anbc-hcb-dev.growth_anlyt_hcb_dev.magicAI_insights t
WHERE t.Last_Update_dt = (
  SELECT MAX(s.Last_Update_dt)
  FROM anbc-hcb-dev.growth_anlyt_hcb_dev.magicAI_insights s
  WHERE s.Dashboard = t.Dashboard
);
