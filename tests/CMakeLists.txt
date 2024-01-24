file(GLOB TEST_SOURCES *.cpp)

add_custom_target(check COMMAND ${CMAKE_CTEST_COMMAND} USES_TERMINAL)

foreach(TEST_SOURCE ${TEST_SOURCES})
	get_filename_component(TEST_NAME ${TEST_SOURCE} NAME_WE)

	add_executable(${TEST_NAME} EXCLUDE_FROM_ALL ${TEST_SOURCE})
	add_dependencies(check ${TEST_NAME})
	add_test(NAME ${TEST_NAME} COMMAND ${TEST_NAME})
endforeach()
