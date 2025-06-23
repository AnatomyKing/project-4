<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Oefening;

class OefeningController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        return Oefening::all();
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
{
    $validated = $request->validate([
        'naam' => 'required|string|max:100',
        'beschrijving_nl' => 'required|string',
        'beschrijving_en' => 'nullable|string',
    ]);

    $oefening = Oefening::create($validated);

    return response()->json($oefening, 201);
}


    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
   public function update(Request $request, $id)
{
    $oefening = Oefening::findOrFail($id);

    $validated = $request->validate([
        'naam' => 'required|string|max:100',
        'beschrijving_nl' => 'required|string',
        'beschrijving_en' => 'nullable|string',
    ]);

    $oefening->update($validated);

    return response()->json($oefening);
}


    /**
     * Remove the specified resource from storage.
     */
    public function destroy($id)
{
    $oefening = Oefening::findOrFail($id);
    $oefening->delete();

    return response()->json(['message' => 'Oefening verwijderd']);
}

}
