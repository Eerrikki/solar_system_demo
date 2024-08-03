
# Scripts

const StellarBody = preload("./stellar_body.gd")
const Settings = preload("res://settings.gd")
const PlanetAtmosphere = preload("res://addons/zylann.atmosphere/planet_atmosphere.gd")

# Assets

const VolumetricAtmosphereScene = preload("res://addons/zylann.atmosphere/planet_atmosphere.tscn")
const BigRock1Scene = preload("../props/big_rocks/big_rock1.tscn")
const Rock1Scene = preload("../props/rocks/rock1.tscn")
const GrassScene = preload("res://props/grass/grass.tscn")

const AtmosphereCloudsHighShader = preload(
	"res://addons/zylann.atmosphere/shaders/planet_atmosphere_v1_clouds_high.gdshader")
const AtmosphereCloudsShader = preload(
	"res://addons/zylann.atmosphere/shaders/planet_atmosphere_v1_clouds.gdshader")
const AtmosphereNoCloudsShader = preload(
	"res://addons/zylann.atmosphere/shaders/planet_atmosphere_v1_no_clouds.gdshader")
const AtmosphereScatteredCloudsHighShader = preload(
	"res://addons/zylann.atmosphere/shaders/planet_atmosphere_clouds_high.gdshader")
const AtmosphereScatteredCloudsShader = preload(
	"res://addons/zylann.atmosphere/shaders/planet_atmosphere_clouds.gdshader")
const AtmosphereScatteredNoCloudsShader = preload(
	"res://addons/zylann.atmosphere/shaders/planet_atmosphere_no_clouds.gdshader")

const CloudShapeTexture3D = preload("./atmosphere/noise_texture_3d.res")
const CloudCoverageTextureEarth = preload("./atmosphere/cloud_coverage_earth.tres")
const CloudCoverageTextureMars = preload("./atmosphere/cloud_coverage_mars.tres")
const CloudCoverageTextureGas = preload("./atmosphere/cloud_coverage_gas.tres")

const SunMaterial = preload("./materials/sun_yellow.tres")
const PlanetRockyMaterial = preload("./materials/planet_material_rocky.tres")
const PlanetGrassyMaterial = preload("./materials/planet_material_grassy.tres")
const WaterSeaMaterial = preload("./materials/water_sea_material.tres")
const RockMaterial = preload("res://props/rocks/rock_material.tres")
const PLANET_MATERIAL_HEIGHTMAP = preload("res://solar_system/materials/planet_material_heightmap.tres")

const Pebble1Mesh = preload("res://props/pebbles/pebble1.obj")
const Rock1Mesh = preload("res://props/rocks/rock1.obj")
const BigRock1Mesh = preload("res://props/big_rocks/big_rock1.obj")

const VOXEL_GRAPH_STELLARBODY = preload("res://solar_system/voxel_graph_stellarbody.tres")

const EarthDaySound = preload("res://sounds/earth_surface_day.ogg")
const EarthNightSound = preload("res://sounds/earth_surface_night.ogg")
const WindSound = preload("res://sounds/wind.ogg")

const _2K_NEPTUNE = preload("res://HDRI/stellar_bodies/2k_neptune.jpg")
const _2K_URANUS = preload("res://HDRI/stellar_bodies/2k_uranus.jpg")
const _4K_CERES_FICTIONAL = preload("res://HDRI/stellar_bodies/4k_ceres_fictional.jpg")
const _8K_EARTH_DAYMAP = preload("res://HDRI/stellar_bodies/8k_earth_daymap.jpg")
const _8K_JUPITER = preload("res://HDRI/stellar_bodies/8k_jupiter.jpg")
const _8K_MARS = preload("res://HDRI/stellar_bodies/8k_mars.jpg")
const _8K_MERCURY = preload("res://HDRI/stellar_bodies/8k_mercury.jpg")
const _8K_MOON = preload("res://HDRI/stellar_bodies/8k_moon.jpg")
const _8K_SATURN = preload("res://HDRI/stellar_bodies/8k_saturn.jpg")
const _8K_SUN = preload("res://HDRI/stellar_bodies/8k_sun.jpg")
const _8K_VENUS_SURFACE = preload("res://HDRI/stellar_bodies/8k_venus_surface.jpg")

const SAVE_FOLDER_PATH = "debug_data"

# Scale used when the large world setting is enabled
const LARGE_SCALE = 1000.0

static func create_solar_system_data(settings: Settings) -> Array[StellarBody]:
	var bodies : Array[StellarBody] = []

	var sun := StellarBody.new()
	sun.type = StellarBody.TYPE_MAIN_SEQUENCE_STAR
	sun.radius = 1500 #696340.0
	sun.self_revolution_time = 25.4 * 24.0 * 60.0 * 60.0
	sun.orbit_revolution_time = 60.0
	sun.name = "Sun"
	bodies.append(sun)

	var planet := StellarBody.new()
	planet.name = "Mercury"
	planet.type = StellarBody.TYPE_TERRESTRIAL_PLANET
	planet.radius = 2439.7
	planet.parent_id = 0
	planet.distance_to_parent = 57909227.0
	planet.self_revolution_time = 58.6462 * 24.0 * 60.0 * 60.0
	planet.orbit_revolution_time = 87.969 * 24.0 * 60.0 * 60.0
	#planet.atmosphere_mode = StellarBody.ATMOSPHERE_MONOCHROME
	planet.atmosphere_mode = StellarBody.ATMOSPHERE_DISABLED
	planet.atmosphere_color = Color(1.0, 0.4, 0.1)
	planet.orbit_revolution_progress = -0.1
	planet.day_ambient_sound = WindSound
	bodies.append(planet)

	planet = StellarBody.new()
	planet.name = "Venus"
	planet.type = StellarBody.TYPE_TERRESTRIAL_PLANET
	planet.radius = 6051.8
	planet.parent_id = 0
	planet.distance_to_parent = 108208930.0
	planet.self_revolution_time = 243.025 * 24.0 * 60.0 * 60.0
	planet.orbit_revolution_time = 224.701 * 24.0 * 60.0 * 60.0
	#planet.atmosphere_mode = StellarBody.ATMOSPHERE_WITH_SCATTERING
	planet.atmosphere_mode = StellarBody.ATMOSPHERE_DISABLED
	planet.atmosphere_color = Color(1.0, 0.8, 0.5)
	planet.orbit_revolution_progress = 0.0
	planet.day_ambient_sound = WindSound
	bodies.append(planet)

	planet = StellarBody.new()
	planet.name = "Earth"
	planet.type = StellarBody.TYPE_TERRESTRIAL_PLANET
	planet.radius = 6371.0
	planet.parent_id = 0
	planet.distance_to_parent = 149597890.0
	planet.self_revolution_time = 23.9345 * 60.0 * 60.0
	planet.orbit_revolution_time = 365.256 * 24.0 * 60.0 * 60.0
	#planet.atmosphere_mode = StellarBody.ATMOSPHERE_WITH_SCATTERING
	planet.atmosphere_mode = StellarBody.ATMOSPHERE_DISABLED
	planet.atmosphere_color = Color(0.75, 0.83, 1.0)
	planet.atmosphere_ambient_color = Color(0.02, 0.02, 0.1)
	planet.orbit_revolution_progress = 0.0
	planet.day_ambient_sound = EarthDaySound
	planet.night_ambient_sound = EarthNightSound
	planet.clouds_coverage_bias = 0.0
	planet.clouds_coverage_cubemap = CloudCoverageTextureEarth
	planet.sea = false
	var earth_id := bodies.size()
	bodies.append(planet)

	planet = StellarBody.new()
	planet.name = "Moon"
	planet.type = StellarBody.TYPE_MOON
	planet.radius = 1737.4
	planet.parent_id = earth_id
	planet.distance_to_parent = 384400.0 * 100
	planet.self_revolution_time = 27.3217 * 24.0 * 60.0 * 60.0
	planet.orbit_revolution_time = 27.3217 * 24.0 * 60.0 * 60.0
	planet.atmosphere_mode = StellarBody.ATMOSPHERE_DISABLED
	planet.orbit_revolution_progress = 0.25
	planet.day_ambient_sound = WindSound
	bodies.append(planet)

	planet = StellarBody.new()
	planet.name = "Mars"
	planet.type = StellarBody.TYPE_TERRESTRIAL_PLANET
	planet.radius = 3389.5  # km
	planet.parent_id = 0
	planet.distance_to_parent = 227939200.0
	planet.self_revolution_time = 24.62 * 60.0 * 60.0
	planet.orbit_revolution_time = 687.0 * 24.0 * 60.0 * 60.0
	#planet.atmosphere_mode = StellarBody.ATMOSPHERE_WITH_SCATTERING
	planet.atmosphere_mode = StellarBody.ATMOSPHERE_DISABLED
	planet.atmosphere_color = Color(1.0, 0.8, 0.5)
	planet.orbit_revolution_progress = 0.1
	planet.day_ambient_sound = WindSound
	planet.clouds_coverage_bias = -0.1
	planet.clouds_coverage_cubemap = CloudCoverageTextureMars
	bodies.append(planet)

	planet = StellarBody.new()
	planet.name = "Jupiter"
	planet.type = StellarBody.TYPE_GAS_GIANT
	planet.radius = 69911.0
	planet.parent_id = 0
	planet.distance_to_parent = 778299000.0
	planet.self_revolution_time = 9.925 * 60.0 * 60.0
	planet.orbit_revolution_time = 4332.62 * 24.0 * 60.0 * 60.0
	#planet.atmosphere_mode = StellarBody.ATMOSPHERE_WITH_SCATTERING
	planet.atmosphere_mode = StellarBody.ATMOSPHERE_DISABLED
	planet.day_ambient_sound = WindSound
	planet.clouds_coverage_bias = 0.2
	planet.clouds_coverage_cubemap = CloudCoverageTextureGas
	bodies.append(planet)

	planet = StellarBody.new()
	planet.name = "Saturn"
	planet.type = StellarBody.TYPE_GAS_GIANT
	planet.radius = 58232.0
	planet.parent_id = 0
	planet.distance_to_parent = 1426725400.0
	planet.self_revolution_time = 10.55 * 60.0 * 60.0
	planet.orbit_revolution_time = 10759.22 * 24.0 * 60.0 * 60.0
	#planet.atmosphere_mode = StellarBody.ATMOSPHERE_WITH_SCATTERING
	planet.atmosphere_mode = StellarBody.ATMOSPHERE_DISABLED
	planet.day_ambient_sound = WindSound
	planet.clouds_coverage_bias = 0.2
	planet.clouds_coverage_cubemap = CloudCoverageTextureGas
	bodies.append(planet)

	planet = StellarBody.new()
	planet.name = "Uranus"
	planet.type = StellarBody.TYPE_ICE_GIANT
	planet.radius = 25362.0
	planet.parent_id = 0
	planet.distance_to_parent = 2870972200.0
	planet.self_revolution_time = 17.9 * 60.0 * 60.0
	planet.orbit_revolution_time = 30687.15 * 24.0 * 60.0 * 60.0
	#planet.atmosphere_mode = StellarBody.ATMOSPHERE_WITH_SCATTERING
	planet.atmosphere_mode = StellarBody.ATMOSPHERE_DISABLED
	planet.day_ambient_sound = WindSound
	planet.clouds_coverage_bias = 0.2
	planet.clouds_coverage_cubemap = CloudCoverageTextureGas
	bodies.append(planet)

	planet = StellarBody.new()
	planet.name = "Neptune"
	planet.type = StellarBody.TYPE_ICE_GIANT
	planet.radius = 24624.0
	planet.parent_id = 0
	planet.distance_to_parent = 4498252900.0
	planet.self_revolution_time = 18.1 * 60.0 * 60.0
	planet.orbit_revolution_time = 60190.03 * 24.0 * 60.0 * 60.0
	#planet.atmosphere_mode = StellarBody.ATMOSPHERE_WITH_SCATTERING
	planet.atmosphere_mode = StellarBody.ATMOSPHERE_DISABLED
	planet.day_ambient_sound = WindSound
	planet.clouds_coverage_bias = 0.2
	planet.clouds_coverage_cubemap = CloudCoverageTextureGas
	bodies.append(planet)

	planet = StellarBody.new()
	planet.name = "Pluto"
	planet.type = StellarBody.TYPE_DWARF_PLANET
	planet.radius = 1185.0
	planet.parent_id = 0
	planet.distance_to_parent = 5906371000.0
	planet.self_revolution_time = 6.387 * 24.0 * 60.0 * 60.0
	planet.orbit_revolution_time = 90683.0 * 24.0 * 60.0 * 60.0
	#planet.atmosphere_mode = StellarBody.ATMOSPHERE_MONOCHROME
	planet.atmosphere_mode = StellarBody.ATMOSPHERE_DISABLED
	planet.atmosphere_color = Color(1.0, 0.4, 0.1)
	planet.orbit_revolution_progress = -0.1
	planet.day_ambient_sound = WindSound
	bodies.append(planet)

	var scale := 1.0
	if settings.world_scale_x10:
		scale = LARGE_SCALE

	for body in bodies:
		body.radius *= scale
		var speed := body.distance_to_parent * TAU / body.orbit_revolution_time
		body.distance_to_parent /= LARGE_SCALE
		body.orbit_revolution_time = body.distance_to_parent * TAU / speed

	return bodies


static func _setup_sun(body: StellarBody, root: Node3D) -> DirectionalLight3D:
	var mi := MeshInstance3D.new()
	var mesh := SphereMesh.new()
	mesh.radius = body.radius
	mesh.height = 2.0 * mesh.radius
	mi.mesh = mesh
	mi.material_override = SunMaterial
	mi.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	root.add_child(mi)

	var directional_light := DirectionalLight3D.new()
	directional_light.shadow_enabled = true
	directional_light.shadow_opacity = 0.99
	directional_light.shadow_normal_bias = 0.2
	directional_light.directional_shadow_split_1 = 0.1
	directional_light.directional_shadow_split_2 = 0.2
	directional_light.directional_shadow_split_3 = 0.5
	directional_light.directional_shadow_blend_splits = true
	directional_light.directional_shadow_max_distance = 20000.0
	directional_light.name = "DirectionalLight"
	body.node.add_child(directional_light)

	return directional_light


static func update_atmosphere_settings(body: StellarBody, settings: Settings):
	var atmo : PlanetAtmosphere = body.atmosphere

	var has_clouds := (body.clouds_coverage_cubemap != null
		and settings.clouds_quality != Settings.CLOUDS_DISABLED)

	if has_clouds:
		if body.atmosphere_mode == StellarBody.ATMOSPHERE_WITH_SCATTERING:
			if settings.clouds_quality == Settings.CLOUDS_HIGH:
				atmo.custom_shader = AtmosphereScatteredCloudsHighShader
			else:
				atmo.custom_shader = AtmosphereScatteredCloudsShader
		else:
			if settings.clouds_quality == Settings.CLOUDS_HIGH:
				atmo.custom_shader = AtmosphereCloudsHighShader
			else:
				atmo.custom_shader = AtmosphereCloudsShader
	else:
		if body.atmosphere_mode == StellarBody.ATMOSPHERE_WITH_SCATTERING:
			atmo.custom_shader = AtmosphereScatteredNoCloudsShader
		else:
			atmo.custom_shader = AtmosphereNoCloudsShader

	#atmo.scale = Vector3(1, 1, 1) * (0.99 * body.radius)
	if settings.world_scale_x10:
		atmo.planet_radius = body.radius * 1.0
		atmo.atmosphere_height = 125.0 * LARGE_SCALE
	else:
		atmo.planet_radius = body.radius * 1.03
		atmo.atmosphere_height = 0.15 * body.radius

	var atmo_density := 0.001

	if body.atmosphere_mode == StellarBody.ATMOSPHERE_WITH_SCATTERING:
		# Scattered atmosphere settings
		atmo_density = 0.04 if settings.world_scale_x10 else 0.05
		atmo.set_shader_parameter(&"u_atmosphere_modulate", body.atmosphere_color)
		atmo.set_shader_parameter(&"u_scattering_strength",
			1.0 if settings.world_scale_x10 else 6.0)
		atmo.set_shader_parameter(&"u_atmosphere_ambient_color", body.atmosphere_ambient_color)
	else:
		if body.type == StellarBody.TYPE_GAS_GIANT:
			if settings.world_scale_x10:
				# TODO Need to investigate this, atmosphere currently blows up HDR when large and dense
				atmo_density /= LARGE_SCALE
		# Settings for the fake color atmospheres
		atmo.set_shader_parameter(&"u_day_color0", body.atmosphere_color)
		atmo.set_shader_parameter(&"u_day_color1", body.atmosphere_color.lerp(Color(1,1,1), 0.5))
		atmo.set_shader_parameter(&"u_night_color0", body.atmosphere_color.darkened(0.8))
		atmo.set_shader_parameter(&"u_night_color1",
			body.atmosphere_color.darkened(0.8).lerp(Color(1,1,1), 0.0))

	atmo.set_shader_parameter(&"u_density", atmo_density)
#	atmo.set_shader_param("u_attenuation_distance", 50.0)

	if has_clouds:
		atmo.set_shader_parameter(&"u_cloud_density_scale",
			0.01 if settings.world_scale_x10 else 0.02)
		atmo.set_shader_parameter(&"u_cloud_shape_texture", CloudShapeTexture3D)
		atmo.set_shader_parameter(&"u_cloud_coverage_cubemap", body.clouds_coverage_cubemap)
		atmo.set_shader_parameter(&"u_cloud_shape_factor", 0.4)
		atmo.set_shader_parameter(&"u_cloud_shape_scale",
			0.001 if settings.world_scale_x10 else 0.005)
		atmo.set_shader_parameter(&"u_cloud_coverage_bias", body.clouds_coverage_bias)
		atmo.set_shader_parameter(&"u_cloud_shape_invert", 1.0)
		atmo.clouds_rotation_speed = 0.05 if settings.world_scale_x10 else 0.5


static func _setup_atmosphere(body: StellarBody, root: Node3D, settings: Settings):
	var atmo : PlanetAtmosphere = VolumetricAtmosphereScene.instantiate()
	body.atmosphere = atmo

	atmo.sun_path = "/root/Main/GameWorld/Sun/DirectionalLight"

	update_atmosphere_settings(body, settings)
	root.add_child(atmo)


static func _setup_sea(body: StellarBody, root: Node3D):
	var sea_mesh := SphereMesh.new()
	sea_mesh.radius = body.radius * 0.985
	sea_mesh.height = 2.0 * sea_mesh.radius
	var sea_mesh_instance := MeshInstance3D.new()
	sea_mesh_instance.mesh = sea_mesh
	sea_mesh_instance.material_override = WaterSeaMaterial
	root.add_child(sea_mesh_instance)

static func image_to_texture(image: Image) -> Texture2D:
	if image == null:
		print("Error: Null image")
		return null
	var texture = ImageTexture.create_from_image(image)
	if texture == null:
		print("Error: Failed to create texture from image")
	return texture

static func _create_stellar_body(body: StellarBody, root: Node3D, settings: Settings):
	var mat : ShaderMaterial
	var generator : VoxelGeneratorGraph = VOXEL_GRAPH_STELLARBODY.duplicate(true)
	var graph : VoxelGraphFunction = generator.get_main_function()
	var sphere_node_id := graph.find_node_by_name("sphere")
	var image_param_id := 0
	var radius_param_id := 1

	if body.name == "Earth":
		mat = PLANET_MATERIAL_HEIGHTMAP.duplicate()
		var texture = image_to_texture(_8K_EARTH_DAYMAP)
		mat.set_shader_parameter("texture_map", texture)
		print("Resource type: ", _8K_EARTH_DAYMAP.get_class())
		print("Texture loaded: ", _8K_EARTH_DAYMAP)
		graph.set_node_param(sphere_node_id, image_param_id, _8K_EARTH_DAYMAP)
		graph.set_node_param(sphere_node_id, radius_param_id, body.radius)

	if body.name == "Mercur":
		mat = PLANET_MATERIAL_HEIGHTMAP.duplicate()
		var texture = image_to_texture(_8K_MERCURY)
		mat.set_shader_parameter("texture_map", texture)
		graph.set_node_param(sphere_node_id, image_param_id, _8K_MERCURY)
		graph.set_node_param(sphere_node_id, radius_param_id, body.radius)

	if body.name == "Mars":
		mat = PLANET_MATERIAL_HEIGHTMAP.duplicate()
		var texture = image_to_texture(_8K_MARS)
		mat.set_shader_parameter("texture_map", texture)
		graph.set_node_param(sphere_node_id, image_param_id, _8K_MARS)
		graph.set_node_param(sphere_node_id, radius_param_id, body.radius)

	if body.name == "Venus":
		mat = PLANET_MATERIAL_HEIGHTMAP.duplicate()
		var texture = image_to_texture(_8K_VENUS_SURFACE)
		mat.set_shader_parameter("texture_map", texture)
		graph.set_node_param(sphere_node_id, image_param_id, _8K_VENUS_SURFACE)
		graph.set_node_param(sphere_node_id, radius_param_id, body.radius)

	if body.name == "Uranus":
		mat = PLANET_MATERIAL_HEIGHTMAP.duplicate()
		var texture = image_to_texture(_2K_URANUS)
		mat.set_shader_parameter("texture_map", texture)
		graph.set_node_param(sphere_node_id, image_param_id, _2K_URANUS)
		graph.set_node_param(sphere_node_id, radius_param_id, body.radius)

	if body.name == "Saturn":
		mat = PLANET_MATERIAL_HEIGHTMAP.duplicate()
		var texture = image_to_texture(_8K_SATURN)
		mat.set_shader_parameter("texture_map", texture)
		graph.set_node_param(sphere_node_id, image_param_id, _8K_SATURN)
		graph.set_node_param(sphere_node_id, radius_param_id, body.radius)

	if body.name == "Jupiter":
		mat = PLANET_MATERIAL_HEIGHTMAP.duplicate()
		var texture = image_to_texture(_8K_JUPITER)
		mat.set_shader_parameter("texture_map", texture)
		graph.set_node_param(sphere_node_id, image_param_id, _8K_JUPITER)
		graph.set_node_param(sphere_node_id, radius_param_id, body.radius)

	if body.name == "Neptun":
		mat = PLANET_MATERIAL_HEIGHTMAP.duplicate()
		var texture = image_to_texture(_2K_NEPTUNE)
		mat.set_shader_parameter("texture_map", texture)
		graph.set_node_param(sphere_node_id, image_param_id, _2K_NEPTUNE)
		graph.set_node_param(sphere_node_id, radius_param_id, body.radius)

	if body.name == "Moon":
		mat = PLANET_MATERIAL_HEIGHTMAP.duplicate()
		var texture = image_to_texture(_8K_MOON)
		mat.set_shader_parameter("texture_map", texture)
		graph.set_node_param(sphere_node_id, image_param_id, _8K_MOON)
		graph.set_node_param(sphere_node_id, radius_param_id, body.radius)

	if body.name == "Sun":
		mat = PLANET_MATERIAL_HEIGHTMAP.duplicate()
		var texture = image_to_texture(_8K_SUN)
		mat.set_shader_parameter("texture_map", texture)
		graph.set_node_param(sphere_node_id, image_param_id, _8K_SUN)
		graph.set_node_param(sphere_node_id, radius_param_id, body.radius)

	generator.compile()
	generator.use_subdivision = true
	generator.subdivision_size = 8
	generator.use_optimized_execution_map = true

	var stream := VoxelStreamSQLite.new()
	stream.database_path = str(SAVE_FOLDER_PATH, "/", body.name, ".sqlite")

	var extra_lods := 0
	if settings.world_scale_x10:
		var temp := int(LARGE_SCALE)
		while temp > 1:
			extra_lods += 1
			temp /= 2

	var pot := 1024
	while body.radius >= pot:
		pot *= 2

	var volume := VoxelLodTerrain.new()
	volume.lod_count = 7 + extra_lods
	volume.lod_distance = 60.0
	volume.collision_lod_count = 2
	volume.generator = generator
	volume.stream = stream
	var view_distance := 100000.0 * 100
	if settings.world_scale_x10:
		view_distance *= LARGE_SCALE
	volume.view_distance = view_distance
	volume.voxel_bounds = AABB(Vector3(-pot, -pot, -pot), Vector3(2 * pot, 2 * pot, 2 * pot))
	volume.lod_fade_duration = 0.3
	volume.threaded_update_enabled = true
	volume.full_load_mode_enabled = true

	volume.normalmap_enabled = false
	volume.normalmap_tile_resolution_min = 4
	volume.normalmap_tile_resolution_max = 8
	volume.normalmap_begin_lod_index = 2
	volume.normalmap_max_deviation_degrees = 50
	volume.normalmap_octahedral_encoding_enabled = false
	volume.normalmap_use_gpu = false

	volume.material = mat
	volume.mesh_block_size = 32

	volume.mesher = VoxelMesherTransvoxel.new()
	volume.mesher.mesh_optimization_error_threshold = 0.0025
	body.volume = volume
	root.add_child(volume)

	#_configure_instancing_for_stellar_body(body, volume)


static func _configure_instancing_for_stellar_body(body: StellarBody, volume: VoxelLodTerrain):
	for mesh in [Pebble1Mesh, Rock1Mesh, BigRock1Mesh]:
		mesh.surface_set_material(0, RockMaterial)

	var instancer := VoxelInstancer.new()
	instancer.set_up_mode(VoxelInstancer.UP_MODE_SPHERE)

	var library := VoxelInstanceLibrary.new()

	var instance_generator := VoxelInstanceGenerator.new()
	instance_generator.density = 0.15
	instance_generator.min_scale = 0.2
	instance_generator.max_scale = 0.4
	instance_generator.min_slope_degrees = 0
	instance_generator.max_slope_degrees = 40
	instance_generator.random_vertical_flip = true
	instance_generator.vertical_alignment = 0.0
	instance_generator.emit_mode = VoxelInstanceGenerator.EMIT_FROM_FACES
	instance_generator.noise = FastNoiseLite.new()
	instance_generator.noise.frequency = 1.0 / 16.0
	instance_generator.noise.fractal_octaves = 2
	instance_generator.noise_on_scale = 1
	var item := VoxelInstanceLibraryMultiMeshItem.new()

	if body.name == "Earth":
		var grass_mesh : Node = GrassScene.instantiate()
		item.setup_from_template(grass_mesh)
		grass_mesh.free()

		#instance_generator.density = 0.32
		instance_generator.density = 2.0
		instance_generator.min_scale = 0.8
		instance_generator.max_scale = 1.6
		instance_generator.random_vertical_flip = false
		instance_generator.max_slope_degrees = 30

		item.name = "grass"

	else:
		item.set_mesh(Pebble1Mesh, 0)
		item.name = "pebbles"

	item.generator = instance_generator
	item.persistent = false
	item.lod_index = 0
	library.add_item(2, item)

	instance_generator = VoxelInstanceGenerator.new()
	instance_generator.density = 0.08
	instance_generator.min_scale = 0.5
	instance_generator.max_scale = 0.8
	instance_generator.min_slope_degrees = 0
	instance_generator.max_slope_degrees = 12
	instance_generator.vertical_alignment = 0.0
	item = VoxelInstanceLibraryMultiMeshItem.new()
	var rock1_template : Node = Rock1Scene.instantiate()
	item.setup_from_template(rock1_template)
	rock1_template.free()
	item.generator = instance_generator
	item.persistent = true
	item.lod_index = 2
	item.name = "rock"
	library.add_item(0, item)

	instance_generator = VoxelInstanceGenerator.new()
	instance_generator.density = 0.03
	instance_generator.min_scale = 0.6
	instance_generator.max_scale = 1.2
	instance_generator.min_slope_degrees = 0
	instance_generator.max_slope_degrees = 10
	instance_generator.vertical_alignment = 0.0
	item = VoxelInstanceLibraryMultiMeshItem.new()
	item.set_mesh(BigRock1Mesh, 0)
	item.generator = instance_generator
	item.persistent = true
	item.lod_index = 3
	item.name = "big_rock"
	library.add_item(1, item)

	instance_generator = VoxelInstanceGenerator.new()
	instance_generator.noise = FastNoiseLite.new()
	instance_generator.noise.frequency = 1.0 / 16.0
	instance_generator.noise.fractal_octaves = 2
	instance_generator.noise_on_scale = 1
	instance_generator.density = 0.06
	instance_generator.min_scale = 0.6
	instance_generator.max_scale = 3.0
	instance_generator.scale_distribution = VoxelInstanceGenerator.DISTRIBUTION_CUBIC
	instance_generator.min_slope_degrees = 140
	instance_generator.max_slope_degrees = 180
	instance_generator.vertical_alignment = 1.0
	instance_generator.offset_along_normal = -0.5
	item = VoxelInstanceLibraryMultiMeshItem.new()
	var cone := CylinderMesh.new()
	cone.radial_segments = 8
	cone.rings = 0
	cone.top_radius = 0.5
	cone.bottom_radius = 0.1
	cone.height = 2.5
	cone.material = RockMaterial
	item.set_mesh(cone, 0)
	item.generator = instance_generator
	item.persistent = true
	item.lod_index = 0
	item.name = "stalactite"
	library.add_item(3, item)

	instancer.library = library

	volume.add_child(instancer)
	body.instancer = instancer


static func setup_stellar_body(body: StellarBody, parent: Node,
	settings: Settings) -> DirectionalLight3D:

	var root := Node3D.new()
	root.name = body.name
	body.node = root
	parent.add_child(root)

	var sun_light : DirectionalLight3D = null

	if body.type == StellarBody.TYPE_MAIN_SEQUENCE_STAR:
		sun_light = _setup_sun(body, root)

	elif body.type != StellarBody.TYPE_MAIN_SEQUENCE_STAR:
		_create_stellar_body(body, root, settings)

	if body.sea:
		_setup_sea(body, root)

	if body.atmosphere_mode != StellarBody.ATMOSPHERE_DISABLED:
		_setup_atmosphere(body, root, settings)

	return sun_light

