<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Person extends Model
{
    use HasFactory;

    public $timestamps = false;

    protected $fillable = ['auth_id', 'name', 'surname', 'type', 'avatar_url', 'group_id'];
}
