<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

Route::group(['prefix' => 'schedules'], function () {
    Route::get('/{groupId}', [\App\Http\Controllers\ScheduleController::class, 'getByGroupId']);
});

Route::group(['prefix' => 'person'], function () {
    Route::get('/{person}', [\App\Http\Controllers\PersonController::class, 'getById']);
});

Route::group(['prefix' => 'teachers'], function () {
    Route::get('/', [\App\Http\Controllers\PersonController::class, 'getTeachers']);
});

Route::group(['prefix' => 'classes'], function () {
    Route::get('/', [\App\Http\Controllers\AudienceController::class, 'index']);
});

Route::group(['prefix' => 'lessons'], function () {
    Route::get('/{teacherId}', [\App\Http\Controllers\LessonController::class, 'getByTeacherId']);
});
