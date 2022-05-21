SELECT 
	accepted_no,
	phylum,
	class,
	"order",
	family,
	genus,
	accepted_name,
	accepted_rank,
	CASE 
		WHEN (max_ma::numeric <= 541) AND (max_ma::numeric >= 252.17) THEN 'Paleozoic'
		WHEN (max_ma::numeric <= 252.17) AND (max_ma::numeric >= 66) THEN 'Mezozoic'
		WHEN (max_ma::numeric <= 66) AND (max_ma::numeric >= 0) THEN 'Cenozoic'
		ELSE 'Unknown'
		END AS Era,
	CASE 
		WHEN (max_ma::numeric <= 541) AND (max_ma::numeric >= 485.4) THEN 'Cambrian'
		WHEN (max_ma::numeric <= 485.4) AND (max_ma::numeric >= 443.4) THEN 'Ordovician'
		WHEN (max_ma::numeric <= 443.4) AND (max_ma::numeric >= 419.2) THEN 'Silurian'
		WHEN (max_ma::numeric <= 419.2) AND (max_ma::numeric >= 358.9) THEN 'Devonian'
		WHEN (max_ma::numeric <= 358.9) AND (max_ma::numeric >= 298.9) THEN 'Carboniferous'
		WHEN (max_ma::numeric <= 298.9) AND (max_ma::numeric >= 252.17) THEN 'Permian'
		WHEN (max_ma::numeric <= 252.17) AND (max_ma::numeric >= 201.3) THEN 'Triassic'
		WHEN (max_ma::numeric <= 201.3) AND (max_ma::numeric >= 145) THEN 'Jurassic'
		WHEN (max_ma::numeric <= 145) AND (max_ma::numeric >= 66) THEN 'Cretaceous'
		WHEN (max_ma::numeric <= 66) AND (max_ma::numeric >= 23.03) THEN 'Paleogene'
		WHEN (max_ma::numeric <= 23.03) AND (max_ma::numeric >= 2.588) THEN 'Neogene'
		WHEN (max_ma::numeric <= 2.588) AND (max_ma::numeric >= 0) THEN 'Quarternary'
		ELSE 'Unknown'
		END AS Period,
	max_ma,
	min_ma,
	taxon_environment,
	motility,
	life_habit,
	vision,
	diet,
	reproduction,
	ontogeny,
	ecospace_comments,
	lng,
	lat
FROM public.animalia

	
